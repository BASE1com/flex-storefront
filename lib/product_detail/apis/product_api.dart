import 'package:dio/dio.dart';
import 'package:flex_storefront/init.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/electronics-spa/products/';
const PARAMS =
    '?fields=code,configurable,configuratorType,name,summary,price(formattedValue,DEFAULT),images(galleryIndex,FULL),baseProduct,averageRating,stock(DEFAULT),description,availableForPickup,url,numberOfReviews,manufacturer,categories(FULL),priceRange,multidimensional,tags&lang=en&curr=USD';

class ProductApi {
  Future<Product> fetchProduct({required String productId}) async {
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get('${dotenv.get('HYBRIS_BASE_URL')}$PATH/$productId$PARAMS');

    return Product.fromJson(response.data);
  }
}
