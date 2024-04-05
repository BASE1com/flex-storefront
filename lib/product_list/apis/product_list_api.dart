import 'package:dio/dio.dart';
import 'package:flex_storefront/search/models/search_results.dart';

const DOMAIN = 'https://localhost:9002';
const PATH = '/occ/v2/electronics-spa/products/search';
const PARAMS =
    '?fields=products(code%2Cname%2Csummary%2Cconfigurable%2CconfiguratorType%2Cmultidimensional%2Cprice(FULL)%2Cimages(DEFAULT)%2Cstock(FULL)%2CaverageRating%2CvariantOptions)%2Cfacets%2Cbreadcrumbs%2Cpagination(DEFAULT)%2Csorts(DEFAULT)%2CfreeTextSearch%2CcurrentQuery&query=%3Arelevance%3AallCategories%3A584&pageSize=12&lang=en&curr=USD';

class ProductListApi {
  final http = Dio();

  Future<SearchResults> fetchProducts() async {
    final response = await http.get('$DOMAIN$PATH$PARAMS');
    return SearchResults.fromJson(response.data);
  }
}
