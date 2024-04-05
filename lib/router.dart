import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/account_page.dart';
import 'package:flex_storefront/cart/cart_page.dart';
import 'package:flex_storefront/category/category_intermediary_page.dart';
import 'package:flex_storefront/category/category_page.dart';
import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/home/home_page.dart';
import 'package:flex_storefront/product_list/product_list_page.dart';
import 'package:flex_storefront/root/root_page.dart';
import 'package:flex_storefront/shop/shop_page.dart';
import 'package:flutter/material.dart';

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
            AutoRoute(
              page: ShopRoute.page,
              path: 'shop',
              children: [
                AutoRoute(
                  page: CategoryRoute.page,
                  path: 'category',
                  initial: true,
                ),
                AutoRoute(
                  page: CategoryIntermediaryRoute.page,
                  path: 'category-interediary',
                ),
                AutoRoute(
                  page: ProductListRoute.page,
                  path: 'product-list',
                ),
              ],
            ),
            AutoRoute(page: CartRoute.page, path: 'cart'),
            AutoRoute(page: AccountRoute.page, path: 'account'),
          ],
        ),
      ];
}
