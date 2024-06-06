import 'package:flex_storefront/checkout/models/checkout_info.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

enum CheckoutPageStatus {
  initial,
  pending,
  failure,
  success,
  // TODO create a PlaceOrderCubit
  orderPlaced,
  orderPending,
  invalid,
}

class CheckoutPageState {
  final CheckoutPageStatus status;
  final CheckoutInfo? checkoutInfo;

  CheckoutPageState({
    required this.status,
    this.checkoutInfo,
  });

  bool get isValid =>
      checkoutInfo?.deliveryAddress != null &&
      checkoutInfo?.deliveryMode != null &&
      checkoutInfo?.paymentInfo != null;

  @override
  String toString() {
    return 'CheckoutPageState{status: $status, checkoutInfo: $checkoutInfo}';
  }

  CheckoutPageState copyWith({
    CheckoutPageStatus? status,
    CheckoutInfo? checkoutInfo,
  }) {
    return CheckoutPageState(
      status: status ?? this.status,
      checkoutInfo: checkoutInfo ?? this.checkoutInfo,
    );
  }
}
