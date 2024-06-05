import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/account/cubits/address_state.dart';
import 'package:flex_storefront/checkout/apis/address_api.dart';
import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit()
      : super(
          AddressState(status: Status.initial),
        );

  Future<void> loadAddresses() async {
    emit(state.copyWith(status: Status.pending));

    final addresses = await GetIt.instance.get<AddressApi>().fetchAddresses();

    emit(state.copyWith(
      status: Status.success,
      addresses: addresses,
    ));
  }

  Future<void> loadCountries() async {
    emit(state.copyWith(status: Status.pending));

    final countries = await GetIt.instance.get<AddressApi>().fetchCountries();

    emit(state.copyWith(
      status: Status.success,
      countries: countries,
    ));
  }

  Future<void> loadRegions({required String isocode}) async {
    emit(state.copyWith(status: Status.pending));

    final regions =
        await GetIt.instance.get<AddressApi>().fetchRegions(isocode);

    emit(state.copyWith(
      status: Status.success,
      regions: regions,
    ));
  }

  Future<void> saveAddress({
    String? cellphone,
    required String countryIsoCode,
    required String firstName,
    required String lastName,
    required String line1,
    String? line2,
    String? phone,
    required String postalCode,
    required String regionIsoCode,
    String? titleCode,
    required String town,
  }) async {
    emit(state.copyWith(status: Status.pending));

    final region = state.regions.firstWhere(
      (r) => r.isocode == regionIsoCode,
    );

    final address = Address(
      cellphone: cellphone,
      country: Country(isocode: countryIsoCode),
      defaultAddress: false,
      firstName: firstName,
      lastName: lastName,
      line1: line1,
      line2: line2,
      phone: phone,
      postalCode: postalCode,
      region: region,
      titleCode: titleCode,
      town: town,
    );

    await GetIt.instance.get<AddressApi>().saveAddress(address);

    emit(state.copyWith(status: Status.success));
  }
}
