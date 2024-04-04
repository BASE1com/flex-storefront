import 'package:dio/dio.dart';
import 'package:flex_storefront/category/models/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const DOMAIN = 'https://flex-cms-fpnplvnjqq-uc.a.run.app';
const PATH = '/api/categories';

class CategoryApi {
  final http = Dio()
    ..options.headers = {
      'Authorization': 'Bearer ${dotenv.get('STRAPI_TOKEN')}',
    };

  Future<List<Category>> fetchCategories({int? parentId}) async {
    final response = await http.get(
        '$DOMAIN$PATH?filters[parent][id]${parentId == null ? '[\$null]=true' : '[\$eq]=$parentId'}&populate=*');

    final result = List<Category>.from(response.data['data'].map(
      (element) => Category.fromJson(element),
    ));

    return result;
  }
}
