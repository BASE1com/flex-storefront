import 'package:dio/dio.dart';
import 'package:flex_storefront/category/apis/category_api.dart';
import 'package:flex_storefront/product_detail/apis/product_api.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:get_it/get_it.dart';

class Singletons {
  static const strapiClient = 'StrapiClient';
  static const hybrisClient = 'HybrisClient';
}

void init() {
  GetIt.instance.registerSingleton(
    Dio()
      ..interceptors.add(LoggyDioInterceptor(responseBody: false))
      ..options.headers = {
        'Authorization': 'Bearer ${dotenv.get('STRAPI_TOKEN')}',
      },
    instanceName: Singletons.strapiClient,
  );
  GetIt.instance.registerSingleton(
    Dio()..interceptors.add(LoggyDioInterceptor(responseBody: false)),
    instanceName: Singletons.hybrisClient,
  );

  GetIt.instance.registerSingleton(CategoryApi());
  GetIt.instance.registerSingleton(ProductApi());
  GetIt.instance.registerSingleton(ProductListApi());
}