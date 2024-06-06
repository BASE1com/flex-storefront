import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/checkout/apis/delivery_mode_api.dart';
import 'package:flex_storefront/checkout/checkout_repository.dart';
import 'package:flex_storefront/checkout/cubits/delivery_mode_selection_state.dart';
import 'package:flex_storefront/checkout/models/checkout_message.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class DeliveryModeSelectionCubit extends Cubit<DeliveryModeSelectionState> {
  late StreamSubscription _checkoutStreamSubscription;
  late StreamSubscription _checkoutMessageStreamSubscription;

  DeliveryModeSelectionCubit()
      : super(
          DeliveryModeSelectionState(status: Status.initial),
        ) {
    _checkoutStreamSubscription =
        GetIt.instance.get<CheckoutRepository>().stream.listen((checkoutInfo) {
      emit(state.copyWith(selectedCode: checkoutInfo.deliveryMode?.code));
    });

    _checkoutMessageStreamSubscription = GetIt.instance
        .get<CheckoutRepository>()
        .messageStream
        .listen((message) {
      if (message is DeliveryAddressUpdated) {
        loadDeliveryModes();
      }
    });
  }

  Future<void> loadDeliveryModes() async {
    emit(state.copyWith(status: Status.pending));

    final cartId = GetIt.instance.get<CartRepository>().currentCart.identifier;

    final deliveryModes =
        await GetIt.instance.get<DeliveryModeApi>().fetchDeliveryModes(cartId);

    emit(state.copyWith(
      status: Status.success,
      deliveryModes: deliveryModes,
    ));
  }

  Future<void> changeDeliveryMode(String code) async {
    emit(state.copyWith(status: Status.pending));

    final cartId = GetIt.instance.get<CartRepository>().currentCart.identifier;

    await GetIt.instance
        .get<CheckoutRepository>()
        .updateDeliveryMode(cartId: cartId, code: code);

    // Refresh the cart as well
    // TODO: Remove that once we move the price breakdown in CheckoutInfo rather than Cart
    await GetIt.instance
        .get<CartRepository>()
        .fetchCart(userType: UserType.current, cartId: cartId);

    emit(state.copyWith(status: Status.success));
  }

  @override
  Future<void> close() async {
    await _checkoutStreamSubscription.cancel();
    await _checkoutMessageStreamSubscription.cancel();
    super.close();
  }
}
