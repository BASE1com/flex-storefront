import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/checkout/apis/address_api.dart';
import 'package:flex_storefront/checkout/checkout_repository.dart';
import 'package:flex_storefront/checkout/cubits/address_selection_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class AddressSelectionCubit extends Cubit<AddressSelectionState> {
  late StreamSubscription _checkoutStreamSubscription;

  AddressSelectionCubit()
      : super(
          AddressSelectionState(status: Status.initial),
        ) {
    _checkoutStreamSubscription =
        GetIt.instance.get<CheckoutRepository>().stream.listen((checkoutInfo) {
      emit(state.copyWith(selectedId: checkoutInfo.deliveryAddress?.id));
    });
  }

  Future<void> loadAddresses() async {
    emit(state.copyWith(status: Status.pending));

    final addresses = await GetIt.instance.get<AddressApi>().fetchAddresses();

    emit(state.copyWith(
      status: Status.success,
      addresses: addresses,
    ));
  }

  Future<void> changeAddress(String addressId) async {
    emit(state.copyWith(status: Status.pending));

    final cartId = GetIt.instance.get<CartRepository>().currentCart.identifier;

    await GetIt.instance
        .get<CheckoutRepository>()
        .updateAddress(cartId: cartId, addressId: addressId);

    emit(state.copyWith(status: Status.success));
  }

  @override
  Future<void> close() async {
    await _checkoutStreamSubscription.cancel();
    super.close();
  }
}
