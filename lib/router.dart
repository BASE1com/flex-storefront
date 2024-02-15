import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/account_page.dart';
import 'package:flex_storefront/cart/cart_page.dart';
import 'package:flex_storefront/home/home_page.dart';
import 'package:flex_storefront/root/root_page.dart';
import 'package:flex_storefront/shop/shop_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RootRoute.page,
          path: '/',
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
            AutoRoute(page: ShopRoute.page, path: 'shop'),
            AutoRoute(page: CartRoute.page, path: 'cart'),
            AutoRoute(page: AccountRoute.page, path: 'account'),
          ],
        ),
      ];
}
