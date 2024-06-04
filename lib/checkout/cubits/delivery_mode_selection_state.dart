import 'package:flex_storefront/checkout/models/delivery_mode.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class DeliveryModeSelectionState extends BlocState {
  final List<DeliveryMode> deliveryModes;
  final String? selectedCode;

  DeliveryModeSelectionState({
    required super.status,
    this.deliveryModes = const [],
    this.selectedCode,
  });

  DeliveryModeSelectionState copyWith({
    Status? status,
    List<DeliveryMode>? deliveryModes,
    String? selectedCode,
  }) =>
      DeliveryModeSelectionState(
        status: status ?? this.status,
        deliveryModes: deliveryModes ?? this.deliveryModes,
        selectedCode: selectedCode ?? this.selectedCode,
      );
}
