import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/cubits/cart_icon_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class CartIconCubit extends Cubit<CartIconState> {
  final CartApi cartApi = CartApi();

  CartIconCubit() : super(CartIconState(status: Status.initial)) {
    _subscribe();
  }

  late final StreamSubscription _cartStreamSubscription;

  Future<void> _subscribe() async {
    _cartStreamSubscription =
        GetIt.instance.get<CartRepository>().getCartStream().listen(
      (cart) {
        emit(CartIconState(
          status: Status.success,
          totalItems: cart.totalItems,
        ));
      },
      onError: (err, stackTrace) {
        emit(CartIconState(status: Status.failure));
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
