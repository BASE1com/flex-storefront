import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/apis/cart_exceptions.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:rxdart/subjects.dart';

const kTestCart = '0cb93e1c-7fba-4b2e-9554-045d37979d78';

class CartRepository {
  CartRepository({
    required CartApi cartApi,
  }) : _cartApi = cartApi {
    init();
  }

  final CartApi _cartApi;

  final _cartStreamController = BehaviorSubject<Cart>();
  final _cartMessageStreamController =
      BehaviorSubject<CartMessage>.seeded(CartInitialize());

  void init() async {
    // TODO: fetch previous carts from local storage
    try {
      final cart = await _cartApi.fetchCart(cartCode: kTestCart);
      _cartStreamController.add(cart);
    } on CartException catch (e) {
      // if the cart is not found, create a new one
      if (e.reason == CartExceptionReason.notFound) {
        _cartMessageStreamController.add(CartNotFound());

        final cart = await _cartApi.createCart();

        _cartStreamController.add(cart);
        _cartMessageStreamController.add(CartReady());
      } else {
        _cartStreamController.addError(e);
      }
    } catch (e) {
      _cartStreamController.addError(e);
    }
  }

  // Provide a [Stream] of the near real-time cart
  Stream<Cart> getCartStream() => _cartStreamController.asBroadcastStream();

  // Provide a [Stream] of important global cart messages
  Stream<CartMessage> getCartMessageStream() =>
      _cartMessageStreamController.asBroadcastStream();

  /// The latest Cart in the stream
  Cart get latestCart => _cartStreamController.value;
  bool get hasCart => _cartStreamController.hasValue;

  Future<void> addProductToCart({
    required Product product,
    required int quantity,
  }) async {
    const cartCode = kTestCart;

    await _cartApi.addProductToCart(
      cartCode: cartCode,
      productCode: product.code,
      quantity: quantity,
    );

    _cartMessageStreamController.add(
      AddToCartMessage(
        product: product,
        quantityAdded: quantity,
      ),
    );

    final cart = await _cartApi.fetchCart(cartCode: kTestCart);
    _cartStreamController.add(cart);
  }

  Future<void> removeProductFromCart({
    required CartItem entry,
  }) async {
    const cartCode = kTestCart;

    await _cartApi.removeProductFromCart(
      cartCode: cartCode,
      entryNumber: entry.entryNumber,
    );

    _cartMessageStreamController.add(
      RemoveFromCartMessage(
        product: entry.product,
      ),
    );

    final cart = await _cartApi.fetchCart(cartCode: kTestCart);
    _cartStreamController.add(cart);
  }

  Future<void> changeQuantityInCart({
    required CartItem entry,
    required int quantity,
  }) async {
    const cartCode = kTestCart;

    await _cartApi.changeQuantityInCart(
      cartCode: cartCode,
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

    final cart = await _cartApi.fetchCart(cartCode: kTestCart);
    _cartStreamController.add(cart);
  }
}
