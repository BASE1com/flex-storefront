import 'package:dio/dio.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/products';
const PARAMS =
    '?fields=code,configurable,configuratorType,name,summary,price(formattedValue,DEFAULT),images(galleryIndex,FULL),baseProduct,averageRating,stock(DEFAULT),description,availableForPickup,url,numberOfReviews,manufacturer,categories(FULL),priceRange,multidimensional,tags&lang=en&curr=USD';

const LIST_PARAMS =
    '?fields=code,name,price(formattedValue,DEFAULT),images(galleryIndex,FULL)&lang=en&curr=USD';

class ProductApi {
  Future<Product> fetchProduct({
    required String productId,
    String fields = PARAMS,
  }) async {
    final path = PATH.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get('${dotenv.get('HYBRIS_BASE_URL')}$path/$productId$fields');

    return Product.fromJson(response.data);
  }
}
