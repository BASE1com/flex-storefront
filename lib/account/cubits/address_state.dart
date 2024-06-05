import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class AddressState extends BlocState {
  final List<Address> addresses;
  final String? selectedId;
  final List<Country> countries;
  final List<Region> regions;

  AddressState({
    required super.status,
    this.addresses = const [],
    this.selectedId,
    this.countries = const [],
    this.regions = const [],
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
        countries: countries ?? this.countries,
        regions: regions ?? this.regions,
      );
}
