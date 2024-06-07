import 'package:flex_storefront/shared/bloc_helper.dart';

class CartIconState {
  final Status status;
  final int totalItems;
  final int totalUnitCount;

  CartIconState({
    required this.status,
    this.totalItems = 0,
    this.totalUnitCount = 0,
  });

  copyWith({
    Status? status,
    int? totalItems,
    int? totalUnitCount,
  }) {
    return CartIconState(
      status: status ?? this.status,
      totalItems: totalItems ?? this.totalItems,
      totalUnitCount: totalUnitCount ?? this.totalUnitCount,
    );
  }

  @override
  String toString() {
    return 'CartIconState{status: $status, totalItems: $totalItems, '
        'totalUnitCount: $totalUnitCount}';
  }
}
