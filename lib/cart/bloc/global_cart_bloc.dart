import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'global_cart_event.dart';
part 'global_cart_state.dart';

/// The job of this Global Bloc would be to provide all dependent blocs with
/// a global, near real-time Stream of the Hybris Cart. This cart could be
/// the anonymous cart or the user cart (or another users cart, depending on
/// who is logged in). As such, this repository should handle:
/// 1. Checking if the user is logged in
/// 2. Checking for the latest cart ids from local device storage
/// 3. Fetching the cart from the Hybris API
/// 4. Providing a Stream (or Futures) of the cart to all dependent blocs (at different speeds)
class GlobalCartBloc extends Bloc<GlobalCartEvent, GlobalCartState> {
  GlobalCartBloc() : super(GlobalCartState(status: Status.initial)) {
    on<GlobalCartInitialize>(_onInitCart);
    on<GlobalCartRequested>(_onCartRequested);

    add(const GlobalCartInitialize());
  }

  Future<void> _onInitCart(
    GlobalCartInitialize event,
    Emitter<GlobalCartState> emit,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    String? anonymousCartGuid =
        sharedPreferences.getString('anonymous_cart_guid');
    anonymousCartGuid ??= 'ccf68d7a-1e14-4da1-99d0-21d1f746cb24';

    emit(GlobalCartState(
      status: Status.success,
      anonymousCartGuid: anonymousCartGuid,
    ));

    add(const GlobalCartRequested());
  }

  Future<void> _onCartRequested(
    GlobalCartRequested event,
    Emitter<GlobalCartState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.pending));

      // TODO: figure out which cart to fetch (anonymous, user, etc.)

      // fetch the cart
      final cart = await GetIt.instance
          .get<CartApi>()
          .fetchCart(cartCode: state.anonymousCartGuid);

      // emit success
      emit(state.copyWith(status: Status.success, cart: cart));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e));
    }
  }
}
