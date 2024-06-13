import 'package:flex_storefront/auth/auth_repository.dart';
import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/apis/cart_exceptions.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:fresh_dio/fresh_dio.dart';
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
  Stream<Cart> get cartStream => _cartStreamController.asBroadcastStream();

  // Provide a [Stream] of important global cart messages
  Stream<CartMessage> getCartMessageStream() =>
      _cartMessageStreamController.asBroadcastStream();

  Cart get currentCart => _cartStreamController.value;
  bool get hasCart => _cartStreamController.hasValue;

  /// Initialize the CartRepository, fetch the last-used cart from
  /// local storage or create a new one to prepare the Cart for usage.
  void init() async {
    loggy.info('Cart initialization started...');

    GetIt.instance.get<AuthRepository>().authStatus.listen((event) async {
      if (event == AuthenticationStatus.unauthenticated) {
        loggy.info('Anonymous cart loading');
        final savedAnonymousCartGuid = GetIt.instance
            .get<SharedPreferences>()
            .getString(ANONYMOUS_CART_GUID);

        if (savedAnonymousCartGuid != null) {
          await fetchCart(
            userType: UserType.anonymous,
            cartId: savedAnonymousCartGuid,
          );
        } else {
          await createCart(userType: UserType.anonymous);
        }
      } else if (event == AuthenticationStatus.authenticated) {
        loggy.info('User cart loading');
        await fetchCart(userType: UserType.current, cartId: 'current');
      }
    });

    loggy.info(
      'Cart initialization ended, cart ready',
    );
  }

  Future<void> fetchCart({
    required UserType userType,
    required String cartId,
  }) async {
    try {
      _cartMessageStreamController.add(CartLoading());

      final cart = await _cartApi.fetchCart(
        userType: userType,
        cartId: cartId,
      );

      _cartStreamController.add(cart);
      _cartMessageStreamController.add(CartReady());
    } on CartException catch (e) {
      // if the cart is not found, create a new one
      if (e.reason == CartExceptionReason.notFound) {
        _cartMessageStreamController.add(CartNotFound());
        await createCart(userType: userType);
      } else {
        _cartStreamController.addError(e);
      }
    } on Exception catch (e) {
      _cartStreamController.addError(e);
    }
  }

  Future<void> refetchCart() async {
    final userType = GetIt.instance.get<AuthRepository>().currentAuthStatus ==
            AuthenticationStatus.authenticated
        ? UserType.current
        : UserType.anonymous;

    try {
      _cartMessageStreamController.add(CartLoading());

      final cart = await _cartApi.fetchCart(
        userType: userType,
        cartId: currentCart.identifier,
      );

      _cartStreamController.add(cart);
      _cartMessageStreamController.add(CartReady());
    } on CartException catch (e) {
      // if the cart is not found, create a new one
      if (e.reason == CartExceptionReason.notFound) {
        _cartMessageStreamController.add(CartNotFound());
      } else {
        _cartStreamController.addError(e);
      }
    } on Exception catch (e) {
      _cartStreamController.addError(e);
    }
  }

  Future<void> createCart({required UserType userType}) async {
    try {
      _cartMessageStreamController.add(CartCreate());
      final cart = await _cartApi.createCart(userType: userType);

      GetIt.instance
          .get<SharedPreferences>()
          .setString(ANONYMOUS_CART_GUID, cart.identifier);

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
      userType: currentCart.userType,
      cartId: currentCart.identifier,
      productCode: product.code,
      quantity: quantity,
    );

    _cartMessageStreamController.add(
      AddToCartMessage(
        product: product,
        quantityAdded: quantity,
      ),
    );

    await fetchCart(
      userType: currentCart.userType,
      cartId: currentCart.identifier,
    );
  }

  Future<void> removeProductFromCart({
    required CartItem entry,
  }) async {
    await _cartApi.removeProductFromCart(
      userType: currentCart.userType,
      cartId: currentCart.identifier,
      entryNumber: entry.entryNumber,
    );

    _cartMessageStreamController.add(
      RemoveFromCartMessage(
        product: entry.product,
      ),
    );

    await fetchCart(
      userType: currentCart.userType,
      cartId: currentCart.identifier,
    );
  }

  Future<void> changeQuantityInCart({
    required CartItem entry,
    required int quantity,
  }) async {
    await _cartApi.changeQuantityInCart(
      userType: currentCart.userType,
      cartId: currentCart.identifier,
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

    await fetchCart(
      userType: currentCart.userType,
      cartId: currentCart.identifier,
    );
  }
}
