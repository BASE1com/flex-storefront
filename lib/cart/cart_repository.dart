import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/cart/models/cart_message.dart';
import 'package:rxdart/subjects.dart';

const kTestCart = '1b2be4d8-c5c7-4b0a-a472-ac7df417d762';

class CartRepository {
  CartRepository({
    required CartApi cartApi,
  }) : _cartApi = cartApi {
    init();
  }

  final CartApi _cartApi;

  late final _cartStreamController = BehaviorSubject<Cart>();
  late final _cartMessageStreamController = BehaviorSubject<CartMessage>.seeded(
    CartReadyMessage('Cart ready!'),
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

  Future<bool> addProductToCart({
    required String productCode,
    required int quantity,
  }) async {
    const cartCode = kTestCart;

    try {
      await _cartApi.addProductToCart(
        cartCode: cartCode,
        productCode: productCode,
        quantity: quantity,
      );

      _cartMessageStreamController.add(
        AddToCartMessage(
          CartMessageType.success,
          'Added $quantity of $productCode to cart',
        ),
      );

      final cart = await _cartApi.fetchCart(cartCode: kTestCart);
      _cartStreamController.add(cart);

      return true;
    } catch (e) {
      _cartMessageStreamController.add(
        AddToCartMessage(
          CartMessageType.error,
          'Failed to add $quantity of $productCode to cart',
        ),
      );

      return false;
    }
  }

  Future<bool> removeProductFromCart({
    required int entryNumber,
  }) async {
    const cartCode = kTestCart;

    try {
      await _cartApi.removeProductFromCart(
        cartCode: cartCode,
        entryNumber: entryNumber,
      );

      _cartMessageStreamController.add(
        AddToCartMessage(
          CartMessageType.success,
          'Removed $entryNumber from cart',
        ),
      );

      final cart = await _cartApi.fetchCart(cartCode: kTestCart);
      _cartStreamController.add(cart);

      return true;
    } catch (e) {
      _cartMessageStreamController.add(
        AddToCartMessage(
          CartMessageType.error,
          'Failed to remove $entryNumber from cart',
        ),
      );

      return false;
    }
  }
}
