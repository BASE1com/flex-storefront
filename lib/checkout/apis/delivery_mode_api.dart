import 'package:dio/dio.dart';
import 'package:flex_storefront/checkout/models/delivery_mode.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const BASE_PATH = '/occ/v2/<CATALOG>/users/current/carts/<CART_ID>';
const LIST_PATH = '$BASE_PATH/deliverymodes';
const UPDATE_PATH = '$BASE_PATH/deliverymode';
const PARAMS = '?lang=en&curr=USD';

class DeliveryModeApi {
  Future<List<DeliveryMode>> fetchDeliveryModes(String cartId) async {
    final path = LIST_PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<CART_ID>', cartId);

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
          '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS',
        );

    final result = List<DeliveryMode>.from(response.data['deliveryModes'].map(
      (element) => DeliveryMode.fromJson(element),
    ));

    return result;
  }

  Future<void> updateDeliveryMode(String cartId, String code) async {
    final path = UPDATE_PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<CART_ID>', cartId);

    await GetIt.instance.get<Dio>(instanceName: Singletons.hybrisClient).put(
        '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS',
        queryParameters: {'deliveryModeId': code});
  }
}
