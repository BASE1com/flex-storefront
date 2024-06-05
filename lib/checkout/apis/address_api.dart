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

  Future<List<Country>> fetchCountries() async {
    final path = '/occ/v2/<CATALOG>/countries'.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
          '${dotenv.get('HYBRIS_BASE_URL')}$path?type=SHIPPING&lang=en&curr=USD',
        );

    final result = List<Country>.from(response.data['countries'].map(
      (element) => Country.fromJson(element),
    ));

    return result;
  }

  Future<List<Region>> fetchRegions(String isocode) async {
    final path = '/occ/v2/<CATALOG>/countries/$isocode/regions'.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
          '${dotenv.get('HYBRIS_BASE_URL')}$path?fields=regions(name,isocode,isocodeShort)&lang=en&curr=USD',
        );

    final result = List<Region>.from(response.data['regions'].map(
      (element) => Region.fromJson(element),
    ));

    return result;
  }

  Future<Address> saveAddress(Address address) async {
    final path = PATH.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final verifyResult = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .post(
          '${dotenv.get('HYBRIS_BASE_URL')}$path/verification$PARAMS',
          data: address.toJson(),
        );

    if (verifyResult.data['decision'] == 'REJECT') {
      throw Exception(verifyResult.data['message']);
    }

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .post(
          '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS',
          data: address.toJson(),
        );

    return Address.fromJson(response.data);
  }
}
