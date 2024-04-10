// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountPage(),
      );
    },
    CartRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CartPage(),
      );
    },
    CategoryIntermediaryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CategoryIntermediaryRouteArgs>(
          orElse: () => CategoryIntermediaryRouteArgs(
                categoryId: pathParams.getInt('categoryId'),
                title: queryParams.optString('title'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoryIntermediaryPage(
          key: args.key,
          categoryId: args.categoryId,
          title: args.title,
        ),
      );
    },
    CategoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoryPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    ProductListRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ProductListRouteArgs>(
          orElse: () => ProductListRouteArgs(
              categoryCode: queryParams.optString('categoryCode')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductListPage(
          key: args.key,
          categoryCode: args.categoryCode,
        ),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    ShopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShopPage(),
      );
    },
  };
}

/// generated route for
/// [AccountPage]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CartPage]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute({List<PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoryIntermediaryPage]
class CategoryIntermediaryRoute
    extends PageRouteInfo<CategoryIntermediaryRouteArgs> {
  CategoryIntermediaryRoute({
    Key? key,
    required int categoryId,
    String? title,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryIntermediaryRoute.name,
          args: CategoryIntermediaryRouteArgs(
            key: key,
            categoryId: categoryId,
            title: title,
          ),
          rawPathParams: {'categoryId': categoryId},
          rawQueryParams: {'title': title},
          initialChildren: children,
        );

  static const String name = 'CategoryIntermediaryRoute';

  static const PageInfo<CategoryIntermediaryRouteArgs> page =
      PageInfo<CategoryIntermediaryRouteArgs>(name);
}

class CategoryIntermediaryRouteArgs {
  const CategoryIntermediaryRouteArgs({
    this.key,
    required this.categoryId,
    this.title,
  });

  final Key? key;

  final int categoryId;

  final String? title;

  @override
  String toString() {
    return 'CategoryIntermediaryRouteArgs{key: $key, categoryId: $categoryId, title: $title}';
  }
}

/// generated route for
/// [CategoryPage]
class CategoryRoute extends PageRouteInfo<void> {
  const CategoryRoute({List<PageRouteInfo>? children})
      : super(
          CategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductListPage]
class ProductListRoute extends PageRouteInfo<ProductListRouteArgs> {
  ProductListRoute({
    Key? key,
    String? categoryCode,
    List<PageRouteInfo>? children,
  }) : super(
          ProductListRoute.name,
          args: ProductListRouteArgs(
            key: key,
            categoryCode: categoryCode,
          ),
          rawQueryParams: {'categoryCode': categoryCode},
          initialChildren: children,
        );

  static const String name = 'ProductListRoute';

  static const PageInfo<ProductListRouteArgs> page =
      PageInfo<ProductListRouteArgs>(name);
}

class ProductListRouteArgs {
  const ProductListRouteArgs({
    this.key,
    this.categoryCode,
  });

  final Key? key;

  final String? categoryCode;

  @override
  String toString() {
    return 'ProductListRouteArgs{key: $key, categoryCode: $categoryCode}';
  }
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShopPage]
class ShopRoute extends PageRouteInfo<void> {
  const ShopRoute({List<PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
