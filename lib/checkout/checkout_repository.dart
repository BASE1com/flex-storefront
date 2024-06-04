import 'dart:async';

import 'package:flex_storefront/checkout/apis/checkout_api.dart';
import 'package:flex_storefront/checkout/models/checkout_info.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

mixin CheckoutRepositoryLoggy implements LoggyType {
  @override
  Loggy<CheckoutRepositoryLoggy> get loggy =>
      Loggy<CheckoutRepositoryLoggy>('CheckoutRepositoryLoggy');
}

class CheckoutRepository with CheckoutRepositoryLoggy {
  CheckoutRepository();

  final _checkoutStreamController = BehaviorSubject<CheckoutInfo>();

  Stream<CheckoutInfo> get stream =>
      _checkoutStreamController.asBroadcastStream();

  Future<void> fetchCheckoutInfo({required String cartId}) async {
    final checkoutInfo = await GetIt.instance
        .get<CheckoutApi>()
        .fetchCheckoutInfo(cartId: cartId);

    _checkoutStreamController.add(checkoutInfo);
  }

  Future<void> updateAddress({
    required String cartId,
    required String addressId,
  }) async {
    await GetIt.instance.get<CheckoutApi>().updateAddress(cartId, addressId);

    await fetchCheckoutInfo(cartId: cartId);
  }

  Future<void> updateDeliveryMode({
    required String cartId,
    required String code,
  }) async {
    await GetIt.instance.get<CheckoutApi>().updateDeliveryMode(cartId, code);

    await fetchCheckoutInfo(cartId: cartId);
  }
}
