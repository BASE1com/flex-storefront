import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CartState {
  final Status status;
  final Cart? cart;

  CartState({
    required this.status,
    this.cart,
  });

  @override
  String toString() {
    return 'CartState{status: $status, products: ${cart?.entries.length}}';
  }
}
