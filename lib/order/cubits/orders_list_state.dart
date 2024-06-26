import 'package:flex_storefront/order/models/order.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class OrdersListState extends BlocState {
  final List<OrderSummary> orders;

  OrdersListState({
    required super.status,
    this.orders = const [],
  });

  OrdersListState copyWith({
    Status? status,
    List<OrderSummary>? orders,
  }) =>
      OrdersListState(
        status: status ?? this.status,
        orders: orders ?? this.orders,
      );
}
