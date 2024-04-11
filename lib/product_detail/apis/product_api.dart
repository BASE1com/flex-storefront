import 'package:dio/dio.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const PATH = '/occ/v2/electronics-spa/products/';
const PARAMS =
    '?fields=code,configurable,configuratorType,name,summary,price(formattedValue,DEFAULT),images(galleryIndex,FULL),baseProduct,averageRating,stock(DEFAULT),description,availableForPickup,url,numberOfReviews,manufacturer,categories(FULL),priceRange,multidimensional,tags&lang=en&curr=USD';

class ProductApi {
  final http = Dio();

  Future<Product> fetchProduct({required String productId}) async {
    final response = await http
        .get('${dotenv.get('HYBRIS_BASE_URL')}$PATH/$productId$PARAMS');

    return Product.fromJson(response.data);
  }
}
