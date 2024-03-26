import 'package:dio/dio.dart';
import 'package:flex_storefront/category_list/models/category.dart';
import 'package:flex_storefront/secrets.dart';

const DOMAIN = 'https://flex-cms-fpnplvnjqq-uc.a.run.app';
const PATH = '/api/categories';

class CategoryApi {
  final http = Dio()
    ..options.headers = {
      'Authorization': 'Bearer $strapiBearerToken',
    };

  Future<List<Category>> fetchCategories({int? parentId}) async {
    final response = await http.get(
        '$DOMAIN$PATH?filters[parent][id]${parentId == null ? '[\$null]=true' : '[\$eq]=$parentId'}&populate=*');

    print(response.statusCode);
    print(response.data['data']);

    final result = List<Category>.from(response.data['data'].map(
      (element) => Category.fromJson(element),
    ));

    print(result);

    return result;
  }
}
