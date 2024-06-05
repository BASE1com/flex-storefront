import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/account/cubits/address_form_state.dart';
import 'package:flex_storefront/checkout/apis/address_api.dart';
import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class AddressFormCubit extends Cubit<AddressFormState> {
  AddressFormCubit()
      : super(
          AddressFormState(status: Status.initial),
        );

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

  Future<void> saveAddress(Map<String, dynamic> formData) async {
    emit(state.copyWith(status: Status.pending));

    final address = Address(
      cellphone: formData['cellphone'],
      country: Country(isocode: formData['countryIsoCode']),
      defaultAddress: false,
      firstName: formData['firstName'],
      lastName: formData['lastName'],
      line1: formData['line1'],
      line2: formData['line2'],
      phone: formData['phone'],
      postalCode: formData['postalCode'],
      region: state.regions.firstWhere(
        (r) => r.isocode == formData['regionIsoCode'],
      ),
      titleCode: formData['titleCode'],
      town: formData['town'],
    );

    await GetIt.instance.get<AddressApi>().saveAddress(address);

    emit(state.copyWith(status: Status.success));
  }
}
