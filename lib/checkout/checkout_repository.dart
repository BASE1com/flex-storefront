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
}
