import 'package:flex_storefront/checkout/models/payment_info.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class PaymentSelectionState extends BlocState {
  final List<PaymentInfo> payments;
  final String? selectedId;

  PaymentSelectionState({
    required super.status,
    this.payments = const [],
    this.selectedId,
  });

  PaymentSelectionState copyWith({
    Status? status,
    List<PaymentInfo>? payments,
    String? selectedId,
  }) =>
      PaymentSelectionState(
        status: status ?? this.status,
        payments: payments ?? this.payments,
        selectedId: selectedId ?? this.selectedId,
      );
}
