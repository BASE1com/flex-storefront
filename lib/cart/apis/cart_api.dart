import 'package:dio/dio.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const PATH = '/occ/v2/electronics-spa/users/anonymous/carts/';
const PARAMS =
    '?fields=DEFAULT,potentialProductPromotions,appliedProductPromotions,potentialOrderPromotions,appliedOrderPromotions,entries(totalPrice(formattedValue),product(images(FULL),stock(FULL)),basePrice(formattedValue,value),updateable),totalPrice(formattedValue),totalItems,totalPriceWithTax(formattedValue),totalDiscounts(value,formattedValue),subTotal(formattedValue),totalUnitCount,deliveryItemsQuantity,deliveryCost(formattedValue),totalTax(formattedValue,%20value),pickupItemsQuantity,net,appliedVouchers,productDiscounts(formattedValue),user,saveTime,name,description&lang=en&curr=USD';

class CartApi {
  final http = Dio();

  Future<Cart> fetchCart({String? cartCode}) async {
    final response =
        await http.get('${dotenv.get('HYBRIS_BASE_URL')}$PATH$cartCode$PARAMS');

    print('Got response: ${response.data}');
    return Cart.fromJson(response.data);
  }
}
