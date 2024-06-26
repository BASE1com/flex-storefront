import 'package:dio/dio.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flex_storefront/order/models/order.dart';
import 'package:flex_storefront/order/models/order_results.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/users/current/orders';
const PARAMS = '?lang=en&curr=USD';

class OrderApi {
  Future<Order> placeOrder(
    String cartId,
    Map<String, dynamic> termsConditionsForm,
  ) async {
    final path = PATH.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .post('${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS', queryParameters: {
      'cartId': cartId,
      ...termsConditionsForm,
    });

    return Order.fromJson(response.data);
  }

  Future<OrderResults> fetchOrders() async {
    final path = PATH.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get('${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS'); // TODO: page size

    return OrderResults.fromJson(response.data);
  }
}
