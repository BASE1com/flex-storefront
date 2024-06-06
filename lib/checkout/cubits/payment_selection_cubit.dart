import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/checkout/apis/payment_api.dart';
import 'package:flex_storefront/checkout/checkout_repository.dart';
import 'package:flex_storefront/checkout/cubits/payment_selection_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class PaymentSelectionCubit extends Cubit<PaymentSelectionState> {
  late StreamSubscription _checkoutStreamSubscription;

  PaymentSelectionCubit()
      : super(
          PaymentSelectionState(status: Status.initial),
        ) {
    _checkoutStreamSubscription =
        GetIt.instance.get<CheckoutRepository>().stream.listen((checkoutInfo) {
      emit(state.copyWith(selectedId: checkoutInfo.paymentInfo?.id));
    });
  }

  Future<void> loadPayments() async {
    emit(state.copyWith(status: Status.pending));

    final payments = await GetIt.instance.get<PaymentApi>().fetchPayments();

    emit(state.copyWith(
      status: Status.success,
      payments: payments,
    ));
  }

  Future<void> changePaymentInfo(String paymentInfoId) async {
    emit(state.copyWith(status: Status.pending));

    final cartId = GetIt.instance.get<CartRepository>().currentCart.identifier;

    await GetIt.instance
        .get<CheckoutRepository>()
        .updatePaymentInfo(cartId: cartId, paymentInfoId: paymentInfoId);

    emit(state.copyWith(status: Status.success));
  }

  @override
  Future<void> close() async {
    await _checkoutStreamSubscription.cancel();
    super.close();
  }
}
