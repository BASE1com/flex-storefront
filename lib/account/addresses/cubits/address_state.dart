import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class AddressState extends BlocState {
  final List<Address> addresses;
  final String? selectedId;

  AddressState({
    required super.status,
    this.addresses = const [],
    this.selectedId,
  });

  AddressState copyWith({
    Status? status,
    List<Address>? addresses,
    String? selectedId,
    List<Country>? countries,
    List<Region>? regions,
  }) =>
      AddressState(
        status: status ?? this.status,
        addresses: addresses ?? this.addresses,
        selectedId: selectedId ?? this.selectedId,
      );
}
