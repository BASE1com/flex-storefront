import 'package:dio/dio.dart';
import 'package:flex_storefront/init.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/electronics-spa/products/search';
const PARAMS =
    '?fields=products(code%2Cname%2Csummary%2Cconfigurable%2CconfiguratorType%2Cmultidimensional%2Cprice(FULL)%2Cimages(DEFAULT)%2Cstock(FULL)%2CaverageRating%2CvariantOptions)%2Cfacets%2Cbreadcrumbs%2Cpagination(DEFAULT)%2Csorts(DEFAULT)%2CfreeTextSearch%2CcurrentQuery&pageSize=12&lang=en&curr=USD';

class ProductListApi {
  Future<SearchResults> fetchProducts({String? categoryCode}) async {
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
            '${dotenv.get('HYBRIS_BASE_URL')}$PATH$PARAMS&query=%3Arelevance%3AallCategories%3A$categoryCode');

    return SearchResults.fromJson(response.data);
  }
}
