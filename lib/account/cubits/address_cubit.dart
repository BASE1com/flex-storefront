import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/account/cubits/address_state.dart';
import 'package:flex_storefront/checkout/apis/address_api.dart';
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
}
