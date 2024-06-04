import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flex_storefront/checkout/models/checkout_info.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/users/current/carts/<CART_ID>';
const PARAMS = '?lang=en&curr=USD';
const CHECKOUT_INFO_FIELDS =
    'deliveryAddress(FULL),deliveryMode(FULL),paymentInfo(FULL)';

class CheckoutApi {
  Future<CheckoutInfo> fetchCheckoutInfo({required String cartId}) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<CART_ID>', cartId);

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get('${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS', queryParameters: {
      'fields': CHECKOUT_INFO_FIELDS,
    });

    log(jsonEncode(response.data));

    return CheckoutInfo.fromJson(response.data);
  }

  Future<void> updateAddress(String cartId, String addressId) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<CART_ID>', cartId);

    await GetIt.instance.get<Dio>(instanceName: Singletons.hybrisClient).put(
        '${dotenv.get('HYBRIS_BASE_URL')}$path/addresses/delivery$PARAMS',
        queryParameters: {'addressId': addressId});
  }

  Future<void> updateDeliveryMode(String cartId, String code) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<CART_ID>', cartId);

    await GetIt.instance.get<Dio>(instanceName: Singletons.hybrisClient).put(
        '${dotenv.get('HYBRIS_BASE_URL')}$path/deliverymode$PARAMS',
        queryParameters: {'deliveryModeId': code});
  }
}
