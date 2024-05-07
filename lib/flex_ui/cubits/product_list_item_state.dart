import 'package:flex_storefront/shared/bloc_helper.dart';

class ProductListItemState {
  final Status status;
  final int quantity;

  ProductListItemState({
    required this.status,
    this.quantity = 0,
  });

  bool get existsInCart => quantity > 0;

  copyWith({
    Status? status,
    int? quantity,
  }) {
    return ProductListItemState(
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'ProductListItemState{status: $status, quantity: $quantity}';
  }
}
