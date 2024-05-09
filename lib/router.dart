import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/account_page.dart';
import 'package:flex_storefront/analytics/apis/analytics_api.dart';
import 'package:flex_storefront/analytics/models/analytics_events.dart';
import 'package:flex_storefront/cart/cart_page.dart';
import 'package:flex_storefront/cart/cart_repository.dart';
import 'package:flex_storefront/category/category_intermediary_page.dart';
import 'package:flex_storefront/category/category_page.dart';
import 'package:flex_storefront/flex_ui/layouts/modal_bottom_sheet.dart';
import 'package:flex_storefront/home/home_page.dart';
import 'package:flex_storefront/product_detail/product_detail_page.dart';
import 'package:flex_storefront/product_list/pages/sort_page.dart';
import 'package:flex_storefront/product_list/pages/filter_page.dart';
import 'package:flex_storefront/product_list/product_list_page.dart';
import 'package:flex_storefront/root/root_page.dart';
import 'package:flex_storefront/search/models/search_results.dart';
import 'package:flex_storefront/shop/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';

part 'router.gr.dart';

class AnalyticsNavigationObserver extends AutoRouterObserver {
  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (route.name == CartRoute.name) {
      final cart = GetIt.instance.get<CartRepository>().hasCart
          ? GetIt.instance.get<CartRepository>().latestCart
          : null;

      GetIt.instance.get<AnalyticsApi>().track(ViewCartEvent.fromCart(cart));
    }
  }
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RootRoute.page,
          path: '/',
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
            AutoRoute(
              page: ShopRoute.page,
              path: 'shop',
              children: [
                AutoRoute(
                  page: CategoryRoute.page,
                  path: 'categories',
                  initial: true,
                ),
                AutoRoute(
                  page: CategoryIntermediaryRoute.page,
                  path: 'category/:categoryId',
                ),
                AutoRoute(
                  page: ProductListRoute.page,
                  path: 'products',
                ),
                AutoRoute(
                  page: ProductDetailRoute.page,
                  path: 'product/:productId',
                ),
              ],
            ),
            AutoRoute(page: CartRoute.page, path: 'cart'),
            AutoRoute(page: AccountRoute.page, path: 'account'),
          ],
        ),
        AutoRoute(
          page: FilterRoute.page,
          path: '/filter',
          fullscreenDialog: true,
        ),
        CustomRoute(
          page: SortRoute.page,
          path: '/sort',
          customRouteBuilder: modalSheetBuilder,
        ),
      ];
}

Route<T> modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return SheetRoute(
    builder: (context) => FlexModalBottomSheet(child: child),
    settings: page,
    fit: SheetFit.loose,
  );
}
