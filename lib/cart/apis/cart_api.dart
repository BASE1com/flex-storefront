import 'package:dio/dio.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/electronics-spa/users/anonymous/carts/';
const PARAMS =
    '?fields=DEFAULT,potentialProductPromotions,appliedProductPromotions,potentialOrderPromotions,appliedOrderPromotions,entries(totalPrice(formattedValue),product(images(FULL),stock(FULL)),basePrice(formattedValue,value),updateable),totalPrice(formattedValue),totalItems,totalPriceWithTax(formattedValue),totalDiscounts(value,formattedValue),subTotal(formattedValue),totalUnitCount,deliveryItemsQuantity,deliveryCost(formattedValue),totalTax(formattedValue,%20value),pickupItemsQuantity,net,appliedVouchers,productDiscounts(formattedValue),user,saveTime,name,description&lang=en&curr=USD';

class CartApi {
  final http = Dio();

  Future<Cart> fetchCart({String? cartCode}) async {
    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get('${dotenv.get('HYBRIS_BASE_URL')}$PATH$cartCode$PARAMS');

    return Cart.fromJson(response.data);
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

    return;
  }
}
