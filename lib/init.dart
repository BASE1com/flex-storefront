import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flex_storefront/analytics/apis/analytics_api.dart';
import 'package:flex_storefront/auth/apis/auth_api.dart';
import 'package:flex_storefront/auth/auth_repository.dart';
import 'package:flex_storefront/cart/apis/cart_api.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/category/apis/category_api.dart';
import 'package:flex_storefront/checkout/apis/checkout_api.dart';
import 'package:flex_storefront/checkout/apis/delivery_mode_api.dart';
import 'package:flex_storefront/checkout/checkout_repository.dart';
import 'package:flex_storefront/cms/apis/cms_api.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/product_detail/apis/product_api.dart';
import 'package:flex_storefront/product_list/apis/product_list_api.dart';
import 'package:flex_storefront/search/apis/suggestion_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Singletons {
  static const strapiClient = 'StrapiClient';
  static const hybrisClient = 'HybrisClient';
}

void init() {
  // Third-party singletons
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

  GetIt.instance.registerSingleton(FirebaseAnalytics.instance);
  GetIt.instance.registerSingletonAsync(() => SharedPreferences.getInstance());

  // Api layer
  GetIt.instance.registerSingleton(AnalyticsApi());
  GetIt.instance.registerSingleton(CategoryApi());
  GetIt.instance.registerSingleton(CmsApi());
  GetIt.instance.registerSingleton(ProductApi());
  GetIt.instance.registerSingleton(ProductListApi());
  GetIt.instance.registerSingleton(SuggestionApi());
  GetIt.instance.registerSingleton(CheckoutApi());
  GetIt.instance.registerSingleton(DeliveryModeApi());

  // Repository layer
  GetIt.instance.registerSingleton(CheckoutRepository());

  GetIt.instance.registerSingletonAsync(() async {
    final ConfigRepository configRepository = ConfigRepository();
    await configRepository.init();
    return configRepository;
  });

  GetIt.instance.registerSingletonWithDependencies(
    () => CartRepository(cartApi: CartApi()),
    dependsOn: [SharedPreferences, ConfigRepository],
  );

  GetIt.instance.registerSingletonAsync(() async {
    final AuthRepository authRepository = AuthRepository(authApi: AuthApi());
    await authRepository.init();
    return authRepository;
  }, dispose: (instance) => instance.dispose());
}
