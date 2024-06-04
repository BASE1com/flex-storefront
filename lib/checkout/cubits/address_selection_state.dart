import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class AddressSelectionState extends BlocState {
  final List<Address> addresses;
  final String? selectedId;

  AddressSelectionState({
    required super.status,
    this.addresses = const [],
    this.selectedId,
  });

  AddressSelectionState copyWith({
    Status? status,
    List<Address>? addresses,
    String? selectedId,
  }) =>
      AddressSelectionState(
        status: status ?? this.status,
        addresses: addresses ?? this.addresses,
        selectedId: selectedId ?? this.selectedId,
      );
}
