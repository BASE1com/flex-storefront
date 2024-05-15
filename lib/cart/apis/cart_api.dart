import 'package:dio/dio.dart';
import 'package:flex_storefront/cart/apis/cart_exceptions.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/electronics-spa/users/anonymous/carts/';
const PARAMS =
    '?fields=DEFAULT,potentialProductPromotions,appliedProductPromotions,potentialOrderPromotions,appliedOrderPromotions,entries(totalPrice(formattedValue),product(images(FULL),stock(FULL)),basePrice(formattedValue,value),updateable),totalPrice(formattedValue),totalItems,totalPriceWithTax(formattedValue),totalDiscounts(value,formattedValue),subTotal(formattedValue),totalUnitCount,deliveryItemsQuantity,deliveryCost(formattedValue),totalTax(formattedValue,%20value),pickupItemsQuantity,net,appliedVouchers,productDiscounts(formattedValue),user,saveTime,name,description&lang=en&curr=USD';

const NEW_CART_PARAMS =
    'DEFAULT,potentialProductPromotions,appliedProductPromotions,potentialOrderPromotions,appliedOrderPromotions,entries(totalPrice(formattedValue),product(images(FULL),stock(FULL)),basePrice(formattedValue,value),updateable),totalPrice(formattedValue),totalItems,totalPriceWithTax(formattedValue),totalDiscounts(value,formattedValue),subTotal(formattedValue),totalUnitCount,deliveryItemsQuantity,deliveryCost(formattedValue),totalTax(formattedValue,%20value),pickupItemsQuantity,net,appliedVouchers,productDiscounts(formattedValue),user&lang=en&curr=USD';

class CartApi {
  final http = Dio();

  Future<Cart> fetchCart({String? cartCode}) async {
    try {
      final response = await GetIt.instance
          .get<Dio>(instanceName: Singletons.hybrisClient)
          .get('${dotenv.get('HYBRIS_BASE_URL')}$PATH$cartCode$PARAMS');

      return Cart.fromJson(response.data);
    } on DioException catch (e) {
      // try to deserialize error response
      if (e.response?.data != null) {
        throw CartException.fromJson(e.response!.data['errors'].first);
      }

      rethrow;
    }
  }

  Future<Cart> createCart() async {
    try {
      final response = await GetIt.instance
          .get<Dio>(instanceName: Singletons.hybrisClient)
          .post('${dotenv.get('HYBRIS_BASE_URL')}$PATH$PARAMS', data: {});

      return Cart.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<void> addProductToCart({
    required String cartCode,
    required String productCode,
    required int quantity,
  }) async {
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .post('${dotenv.get('HYBRIS_BASE_URL')}$PATH$cartCode/entries', data: {
      'product': {'code': productCode},
      'quantity': quantity,
    });

    // TODO: handle response deserialization
    return;
  }

  Future<void> removeProductFromCart({
    required String cartCode,
    required int entryNumber,
  }) async {
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .delete(
            '${dotenv.get('HYBRIS_BASE_URL')}$PATH$cartCode/entries/$entryNumber');

    // TODO: handle response deserialization
    return;
  }

  Future<void> changeQuantityInCart({
    required String cartCode,
    required int entryNumber,
    required int quantity,
  }) async {
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .patch(
            '${dotenv.get('HYBRIS_BASE_URL')}$PATH$cartCode/entries/$entryNumber',
            data: {
          'quantity': quantity,
        });

    // TODO: handle response deserialization
    return;
  }
}
