import 'package:dio/dio.dart';
import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/users/current/addresses';
const PARAMS = '?lang=en&curr=USD';

class AddressApi {
  Future<List<Address>> fetchAddresses() async {
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

    final result = List<Address>.from(response.data['addresses'].map(
      (element) => Address.fromJson(element),
    ));

    return result;
  }
}
