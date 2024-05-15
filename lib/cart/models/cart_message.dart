import 'package:flex_storefront/product_list/models/product.dart';

abstract class CartMessage {
  const CartMessage();
}

class CartInitialize extends CartMessage {}

class CartNotFound extends CartMessage {}

class CartReady extends CartMessage {}

/// Add a product to the Cart.
/// This event is fired when the product wasn't in the Cart before
/// (i.e. no cart entry with this product)
class AddToCartMessage extends CartMessage {
  final Product product;
  final int quantityAdded;

  const AddToCartMessage({
    required this.product,
    required this.quantityAdded,
  });
}

/// Remove a Product from the Cart.
/// This event is fired when the product is no longer in the cart
/// (i.e. no cart entry with this product anymore)
class RemoveFromCartMessage extends CartMessage {
  final Product product;

  const RemoveFromCartMessage({
    required this.product,
  });
}

/// Adjust the quantity of an existing product in the Cart.
class ChangeQuantityMessage extends CartMessage {
  final Product product;
  final int oldQuantity;
  final int newQuantity;

  const ChangeQuantityMessage({
    required this.product,
    required this.oldQuantity,
    required this.newQuantity,
  });
}
