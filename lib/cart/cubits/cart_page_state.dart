import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CartPageState {
  final Status status;
  final Cart? cart;

  CartPageState({
    required this.status,
    this.cart,
  });

  copyWith({
    Status? status,
    Cart? cart,
  }) {
    return CartPageState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
    );
  }

  @override
  String toString() {
    return 'CartPageState{status: $status, products: ${cart?.entries.length}}';
  }
}
