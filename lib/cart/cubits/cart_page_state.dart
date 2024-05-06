import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CartPageState {
  final Status status;
  final Cart? cart;

  CartPageState({
    required this.status,
    this.cart,
  });

  @override
  String toString() {
    return 'CartPageState{status: $status, products: ${cart?.entries.length}}';
  }
}
