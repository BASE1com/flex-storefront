import 'package:dio/dio.dart';
import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/init.dart';
import 'package:get_it/get_it.dart';

const DOMAIN = 'flex-cms-fpnplvnjqq-uc.a.run.app';
const PATH = '/api/categories';

class CategoryApi {
  Future<List<Category>> fetchRootCategories() async {
    final queryString = {
      'filters[parent][id][\$null]': 'true',
      'fields[0]': 'id',
      'fields[1]': 'code',
      'fields[2]': 'name',
      'fields[3]': 'destination',
    };

    final uri = Uri.https(DOMAIN, PATH, queryString);
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.strapiClient)
        .get(uri.toString());

    final result = List<Category>.from(response.data['data'].map(
      (element) => Category.fromJson(element),
    ));

    return result;
  }

  Future<Category> fetchCategory({required int categoryId}) async {
    final queryString = {
      'fields[0]': 'id',
      'fields[1]': 'code',
      'fields[2]': 'name',
      'fields[3]': 'destination',
      'populate[children][fields][0]': 'id',
      'populate[children][fields][1]': 'code',
      'populate[children][fields][2]': 'name',
      'populate[children][fields][3]': 'destination',
    };

    final uri = Uri.https(DOMAIN, '$PATH/$categoryId', queryString);
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.strapiClient)
        .get(uri.toString());

    final result = Category.fromJson(response.data['data']);

    return result;
  }
}
