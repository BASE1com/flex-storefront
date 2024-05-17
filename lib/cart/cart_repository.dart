import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/apis/cart_exceptions.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

const ANONYMOUS_CART_GUID = 'anonymous_cart_guid';

mixin CartRepositoryLoggy implements LoggyType {
  @override
  Loggy<CartRepositoryLoggy> get loggy =>
      Loggy<CartRepositoryLoggy>('CartRepositoryLoggy');
}

class CartRepository with CartRepositoryLoggy {
  CartRepository({
    required CartApi cartApi,
  }) : _cartApi = cartApi {
    init();
  }

  final CartApi _cartApi;

  final _cartStreamController = BehaviorSubject<Cart>();
  final _cartMessageStreamController =
      BehaviorSubject<CartMessage>.seeded(CartInitialize());

  // Provide a [Stream] of the near real-time cart
  Stream<Cart> getCartStream() => _cartStreamController.asBroadcastStream();

  // Provide a [Stream] of important global cart messages
  Stream<CartMessage> getCartMessageStream() =>
      _cartMessageStreamController.asBroadcastStream();

  String get cartId =>
      GetIt.instance.get<SharedPreferences>().getString(ANONYMOUS_CART_GUID) ??
      '';
  Cart get currentCart => _cartStreamController.value;
  bool get hasCart => _cartStreamController.hasValue;

  /// Initialize the CartRepository, fetch the last-used cart from
  /// local storage or create a new one to prepare the Cart for usage.
  void init() async {
    // 1. check local storage
    loggy.info(
      'Cart initialization started, local storage cartId: $cartId',
    );

    if (cartId.isNotEmpty) {
      await fetchCart();
    } else {
      await createCart();
    }

    loggy.info(
      'Cart initialization ended, cart ready',
    );
  }

  Future<void> fetchCart() async {
    try {
      final cart = await _cartApi.fetchCart(cartCode: cartId);
      _cartStreamController.add(cart);
      _cartMessageStreamController.add(CartReady());
    } on CartException catch (e) {
      // if the cart is not found, create a new one
      if (e.reason == CartExceptionReason.notFound) {
        _cartMessageStreamController.add(CartNotFound());
        await createCart();
      } else {
        _cartStreamController.addError(e);
      }
    } on Exception catch (e) {
      _cartStreamController.addError(e);
    }
  }

  Future<void> createCart() async {
    try {
      _cartMessageStreamController.add(CartCreate());
      final cart = await _cartApi.createCart();

      GetIt.instance
          .get<SharedPreferences>()
          .setString(ANONYMOUS_CART_GUID, cart.guid);

      _cartStreamController.add(cart);
      _cartMessageStreamController.add(CartReady());
    } catch (e) {
      _cartStreamController.addError(e);
    }
  }

  Future<void> addProductToCart({
    required Product product,
    required int quantity,
  }) async {
    await _cartApi.addProductToCart(
      cartCode: cartId,
      productCode: product.code,
      quantity: quantity,
    );

    _cartMessageStreamController.add(
      AddToCartMessage(
        product: product,
        quantityAdded: quantity,
      ),
    );

    await fetchCart();
  }

  Future<void> removeProductFromCart({
    required CartItem entry,
  }) async {
    await _cartApi.removeProductFromCart(
      cartCode: cartId,
      entryNumber: entry.entryNumber,
    );

    _cartMessageStreamController.add(
      RemoveFromCartMessage(
        product: entry.product,
      ),
    );

    await fetchCart();
  }

  Future<void> changeQuantityInCart({
    required CartItem entry,
    required int quantity,
  }) async {
    await _cartApi.changeQuantityInCart(
      cartCode: cartId,
      entryNumber: entry.entryNumber,
      quantity: quantity,
    );

    _cartMessageStreamController.add(
      ChangeQuantityMessage(
        product: entry.product,
        oldQuantity: entry.quantity,
        newQuantity: quantity,
      ),
    );

    await fetchCart();
  }
}
