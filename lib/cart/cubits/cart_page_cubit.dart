import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/cubits/cart_page_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class CartPageCubit extends Cubit<CartPageState> {
  final CartApi cartApi = CartApi();

  CartPageCubit() : super(CartPageState(status: Status.pending));

  late final StreamSubscription _cartStreamSubscription;

  Future<void> subscribe() async {
    _cartStreamSubscription =
        GetIt.instance.get<CartRepository>().getCartStream().listen(
      (cart) {
        emit(CartPageState(
          status: Status.success,
          cart: cart,
        ));
      },
      onError: (err, stackTrace) {
        emit(CartPageState(status: Status.failure));
        addError(err, stackTrace);
      },
    );
  }

  @override
  Future<void> close() {
    _cartStreamSubscription.cancel();
    return super.close();
  }
}
