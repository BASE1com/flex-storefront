import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CartState {
  final Status status;
  final List<Product> products;
  final CartPrice? totalPrice;

  CartState({
    required this.status,
    this.products = const [],
    this.totalPrice,
  });

  @override
  String toString() {
    return 'CartState{status: $status, products: ${products.length}}';
  }
}
