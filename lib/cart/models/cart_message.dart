import 'package:flex_storefront/product_list/models/product.dart';

abstract class CartMessage {}

class CartReadyMessage extends CartMessage {}

class ChangeQuantityMessage extends CartMessage {
  final Product product;
  final int quantityDiff;

  ChangeQuantityMessage(
    this.product,
    this.quantityDiff,
  );
}
