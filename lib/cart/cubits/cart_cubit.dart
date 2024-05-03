import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/bloc/global_cart_bloc.dart';
import 'package:flex_storefront/cart/cubits/cart_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required GlobalCartBloc globalCartBloc,
  })  : _globalCartBloc = globalCartBloc,
        super(CartState(status: Status.pending)) {
    subscribe();
  }

  final GlobalCartBloc _globalCartBloc;
  late final StreamSubscription<GlobalCartState> _streamSubscription;

  Future<void> subscribe() async {
    _streamSubscription = _globalCartBloc.stream.listen(
      (state) {
        if (state.status == Status.success) {
          emit(CartState(
            status: Status.success,
            cart: state.cart,
          ));
        }
      },
    );
  }

  Future<void> loadCart() async {
    try {
      emit(CartState(status: Status.pending));
      _globalCartBloc.add(const GlobalCartRequested());
    } catch (err) {
      emit(CartState(status: Status.failure));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
