import 'package:dio/dio.dart';
import 'package:flex_storefront/checkout/models/payment_info.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/users/current/paymentdetails';
const PARAMS = '?saved=true&lang=en&curr=USD';

class PaymentApi {
  Future<List<PaymentInfo>> fetchPayments() async {
    final path = PATH.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
          '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS',
        );

    final result = List<PaymentInfo>.from(response.data['payments'].map(
      (element) => PaymentInfo.fromJson(element),
    ));

    return result;
  }
}
