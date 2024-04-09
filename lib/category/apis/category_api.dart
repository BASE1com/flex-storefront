import 'package:dio/dio.dart';
import 'package:flex_storefront/category/models/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const DOMAIN = 'flex-cms-fpnplvnjqq-uc.a.run.app';
const PATH = '/api/categories';

class CategoryApi {
  final http = Dio()
    ..options.headers = {
      'Authorization': 'Bearer ${dotenv.get('STRAPI_TOKEN')}',
    };

  Future<List<Category>> fetchRootCategories() async {
    final queryString = {
      'filters[parent][id][\$null]': 'true',
      'fields[0]': 'id',
      'fields[1]': 'name',
      'populate[image][fields][0]': 'id',
      'populate[image][fields][1]': 'url',
      'populate[image][fields][2]': 'name',
      'populate[children][fields][0]': 'id',
      'populate[children][fields][1]': 'name',
    };

    final uri = Uri.https(DOMAIN, PATH, queryString);
    final response = await http.get(uri.toString());

    final result = List<Category>.from(response.data['data'].map(
      (element) => Category.fromJson(element),
    ));

    return result;
  }

  Future<Category> fetchCategory({required int categoryId}) async {
    final queryString = {
      'fields[0]': 'id',
      'fields[1]': 'name',
      'populate[image][fields][0]': 'id',
      'populate[image][fields][1]': 'url',
      'populate[image][fields][2]': 'name',
      'populate[children][fields][0]': 'id',
      'populate[children][fields][1]': 'name',
      'populate[children][populate][children][fields][0]': 'id',
      'populate[children][populate][children][fields][1]': 'name',
    };

    final uri = Uri.https(DOMAIN, '$PATH/$categoryId', queryString);
    final response = await http.get(uri.toString());

    final result = Category.fromJson(response.data['data']);

    return result;
  }
}