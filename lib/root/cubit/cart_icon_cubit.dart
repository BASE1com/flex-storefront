import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/bloc/global_cart_bloc.dart';
import 'package:flex_storefront/root/cubit/cart_icon_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CartIconCubit extends Cubit<CartIconState> {
  CartIconCubit({
    required GlobalCartBloc globalCartBloc,
  })  : _globalCartBloc = globalCartBloc,
        super(CartIconState(status: Status.success)) {
    subscribe();
  }

  final GlobalCartBloc _globalCartBloc;
  late final StreamSubscription<GlobalCartState> _streamSubscription;

  Future<void> subscribe() async {
    _streamSubscription = _globalCartBloc.stream.listen(
      (state) {
        if (state.status == Status.success) {
          emit(CartIconState(
            status: Status.success,
            totalItems: state.totalItems,
          ));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
