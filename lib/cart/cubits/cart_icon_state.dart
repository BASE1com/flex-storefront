import 'package:flex_storefront/shared/bloc_helper.dart';

class CartIconState {
  final Status status;
  final int totalItems;

  CartIconState({
    required this.status,
    this.totalItems = 0,
  });

  @override
  String toString() {
    return 'CartIconState{status: $status, totalItems: $totalItems}';
  }
}
