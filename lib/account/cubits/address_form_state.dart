import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class AddressFormState extends BlocState {
  final Address? address;
  final List<Country> countries;
  final List<Region> regions;

  AddressFormState({
    required super.status,
    this.address,
    this.countries = const [],
    this.regions = const [],
  });

  AddressFormState copyWith({
    Status? status,
    Address? addresses,
    List<Country>? countries,
    List<Region>? regions,
  }) =>
      AddressFormState(
        status: status ?? this.status,
        address: address ?? this.address,
        countries: countries ?? this.countries,
        regions: regions ?? this.regions,
      );
}
