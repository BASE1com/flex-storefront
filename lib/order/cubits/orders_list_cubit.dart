import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/order/apis/order_api.dart';
import 'package:flex_storefront/order/cubits/orders_list_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  OrdersListCubit() : super(OrdersListState(status: Status.initial));

  Future<void> loadOrders() async {
    emit(state.copyWith(status: Status.pending));
    final results = await GetIt.instance.get<OrderApi>().fetchOrders();
    emit(state.copyWith(orders: results.orders, status: Status.success));
  }
}
