import 'package:dio/dio.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/products/suggestions';
const PARAMS = '?lang=en&curr=USD';

class SuggestionApi {
  Future<List<String>> fetchSuggestions({
    required String query,
    int page = 0,
    int? limit,
  }) async {
    final path = PATH.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
            '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS&term=$query${limit != null ? '&max=$limit' : ''}');

    final values = response.data['suggestions'].map((obj) => obj['value']);

    return List<String>.from(values);
  }
}
