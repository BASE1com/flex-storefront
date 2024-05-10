import 'package:flex_storefront/cart/apis/cart_api.dart';
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
  final _cartMessageStreamController = BehaviorSubject<CartMessage>.seeded(
    CartReadyMessage(),
  );

  void init() async {
    // TODO: proper initialization, find anonymous or user cart, or create one?
    final cart = await _cartApi.fetchCart(cartCode: kTestCart);
    _cartStreamController.add(cart);
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
