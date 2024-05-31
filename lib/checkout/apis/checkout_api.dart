import 'package:dio/dio.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/checkout/models/checkout_info.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/users/current/carts/';
const PARAMS =
    '?fields=deliveryAddress(FULL),deliveryMode(FULL),paymentInfo(FULL)&lang=en&curr=USD';

class CheckoutApi {
  Future<CheckoutInfo> fetchCheckoutInfo({required String cartId}) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<USER_TYPE>', UserType.current.name);

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
          '${dotenv.get('HYBRIS_BASE_URL')}$path$cartId$PARAMS',
        );

    return CheckoutInfo.fromJson(response.data);
  }
}
