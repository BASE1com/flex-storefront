import 'package:dio/dio.dart';
import 'package:flex_storefront/cart/apis/cart_exceptions.dart';
import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/users/<USER_TYPE>/carts/';
const PARAMS =
    '?fields=DEFAULT,potentialProductPromotions,appliedProductPromotions,potentialOrderPromotions,appliedOrderPromotions,entries(totalPrice(formattedValue),product(images(FULL),stock(FULL)),basePrice(formattedValue,value),updateable),totalPrice(formattedValue),totalItems,totalPriceWithTax(formattedValue),totalDiscounts(value,formattedValue),subTotal(formattedValue),totalUnitCount,deliveryItemsQuantity,deliveryCost(formattedValue),totalTax(formattedValue,%20value),pickupItemsQuantity,net,appliedVouchers,productDiscounts(formattedValue),saveTime,name,description&lang=en&curr=USD';

const NEW_CART_PARAMS =
    'DEFAULT,potentialProductPromotions,appliedProductPromotions,potentialOrderPromotions,appliedOrderPromotions,entries(totalPrice(formattedValue),product(images(FULL),stock(FULL)),basePrice(formattedValue,value),updateable),totalPrice(formattedValue),totalItems,totalPriceWithTax(formattedValue),totalDiscounts(value,formattedValue),subTotal(formattedValue),totalUnitCount,deliveryItemsQuantity,deliveryCost(formattedValue),totalTax(formattedValue,%20value),pickupItemsQuantity,net,appliedVouchers,productDiscounts(formattedValue)&lang=en&curr=USD';

class CartApi {
  final http = Dio();

  Future<Cart> fetchCart({required UserType userType, String? cartId}) async {
    try {
      final path = PATH
          .replaceAll(
            '<CATALOG>',
            GetIt.instance
                .get<ConfigRepository>()
                .getString(ConfigKey.shopHybrisCatalog),
          )
          .replaceAll('<USER_TYPE>', userType.name);

      final response = await GetIt.instance
          .get<Dio>(instanceName: Singletons.hybrisClient)
          .get(
            '${dotenv.get('HYBRIS_BASE_URL')}$path$cartId$PARAMS',
          );

      return Cart.fromJson(userType, response.data);
    } on DioException catch (e) {
      // try to deserialize error response
      if (e.response?.data?['errors']?.isNotEmpty) {
        print(e.response!.data['errors']);
        throw CartException.fromJson(e.response!.data['errors'].first);
      }

      rethrow;
    }
  }

  Future<Cart> createCart({
    required UserType userType,
  }) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<USER_TYPE>', userType.name);

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .post('${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS', data: {});

    return Cart.fromJson(userType, response.data);
  }

  Future<void> addProductToCart({
    required UserType userType,
    required String cartId,
    required String productCode,
    required int quantity,
  }) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<USER_TYPE>', userType.name);

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .post('${dotenv.get('HYBRIS_BASE_URL')}$path$cartId/entries', data: {
      'product': {'code': productCode},
      'quantity': quantity,
    });

    // TODO: handle response deserialization
    return;
  }

  Future<void> removeProductFromCart({
    required UserType userType,
    required String cartId,
    required int entryNumber,
  }) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<USER_TYPE>', userType.name);

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .delete(
            '${dotenv.get('HYBRIS_BASE_URL')}$path$cartId/entries/$entryNumber');

    // TODO: handle response deserialization
    return;
  }

  Future<void> changeQuantityInCart({
    required UserType userType,
    required String cartId,
    required int entryNumber,
    required int quantity,
  }) async {
    final path = PATH
        .replaceAll(
          '<CATALOG>',
          GetIt.instance
              .get<ConfigRepository>()
              .getString(ConfigKey.shopHybrisCatalog),
        )
        .replaceAll('<USER_TYPE>', userType.name);

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .patch(
            '${dotenv.get('HYBRIS_BASE_URL')}$path$cartId/entries/$entryNumber',
            data: {
          'quantity': quantity,
        });

    // TODO: handle response deserialization
    return;
  }
}
