import 'package:flex_storefront/shared/bloc_helper.dart';

class CartIconState extends BlocState {
  final int totalItems;

  CartIconState({
    required super.status,
    super.error,
    super.stackTrace,
    this.totalItems = 0,
  });

  @override
  String toString() {
    return 'CartIconState{status: $status, totalItems: $totalItems}';
  }
}
