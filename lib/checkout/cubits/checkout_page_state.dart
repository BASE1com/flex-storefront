import 'package:flex_storefront/checkout/models/checkout_info.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class CheckoutPageState extends BlocState {
  final CheckoutInfo? checkoutInfo;

  CheckoutPageState({
    required super.status,
    super.error,
    super.stackTrace,
    this.checkoutInfo,
  });

  @override
  String toString() {
    return 'CheckoutPageState{checkoutInfo: $checkoutInfo}';
  }

  CheckoutPageState copyWith({
    Status? status,
    CheckoutInfo? checkoutInfo,
  }) {
    return CheckoutPageState(
      status: status ?? this.status,
      checkoutInfo: checkoutInfo ?? this.checkoutInfo,
    );
  }
}
