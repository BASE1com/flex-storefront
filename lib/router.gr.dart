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
    AddressRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddressPage(),
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
    CheckoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CheckoutPage(),
      );
    },
    EditAccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditAccountPage(),
      );
    },
    EditUserNameRoute.name: (routeData) {
      final args = routeData.argsAs<EditUserNameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditUserNamePage(
          key: args.key,
          user: args.user,
          onSave: args.onSave,
        ),
      );
    },
    FilterRoute.name: (routeData) {
      final args = routeData.argsAs<FilterRouteArgs>(
          orElse: () => const FilterRouteArgs());
      return AutoRoutePage<FacetValue?>(
        routeData: routeData,
        child: FilterPage(
          key: args.key,
          facets: args.facets,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(
          key: args.key,
          onLoginAttempt: args.onLoginAttempt,
        ),
      );
    },
    MyAccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyAccountPage(),
      );
    },
    NewAddressRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewAddressPage(),
      );
    },
    OrderConfirmationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderConfirmationPage(),
      );
    },
    OrderListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderListPage(),
      );
    },
    ProductDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailRouteArgs>(
          orElse: () => ProductDetailRouteArgs(
              productId: pathParams.getString('productId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductDetailPage(
          key: args.key,
          productId: args.productId,
        ),
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
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchPage(),
      );
    },
    SearchProductRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<SearchProductRouteArgs>(
          orElse: () => SearchProductRouteArgs(
              searchTerm: queryParams.optString('searchTerm')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchProductPage(
          key: args.key,
          searchTerm: args.searchTerm,
        ),
      );
    },
    ShopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShopPage(),
      );
    },
    SortRoute.name: (routeData) {
      final args =
          routeData.argsAs<SortRouteArgs>(orElse: () => const SortRouteArgs());
      return AutoRoutePage<Sort?>(
        routeData: routeData,
        child: SortPage(
          key: args.key,
          sorts: args.sorts,
        ),
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
/// [AddressPage]
class AddressRoute extends PageRouteInfo<void> {
  const AddressRoute({List<PageRouteInfo>? children})
      : super(
          AddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressRoute';

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
/// [CheckoutPage]
class CheckoutRoute extends PageRouteInfo<void> {
  const CheckoutRoute({List<PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditAccountPage]
class EditAccountRoute extends PageRouteInfo<void> {
  const EditAccountRoute({List<PageRouteInfo>? children})
      : super(
          EditAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditAccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditUserNamePage]
class EditUserNameRoute extends PageRouteInfo<EditUserNameRouteArgs> {
  EditUserNameRoute({
    Key? key,
    required User user,
    required void Function(Map<String, dynamic>) onSave,
    List<PageRouteInfo>? children,
  }) : super(
          EditUserNameRoute.name,
          args: EditUserNameRouteArgs(
            key: key,
            user: user,
            onSave: onSave,
          ),
          initialChildren: children,
        );

  static const String name = 'EditUserNameRoute';

  static const PageInfo<EditUserNameRouteArgs> page =
      PageInfo<EditUserNameRouteArgs>(name);
}

class EditUserNameRouteArgs {
  const EditUserNameRouteArgs({
    this.key,
    required this.user,
    required this.onSave,
  });

  final Key? key;

  final User user;

  final void Function(Map<String, dynamic>) onSave;

  @override
  String toString() {
    return 'EditUserNameRouteArgs{key: $key, user: $user, onSave: $onSave}';
  }
}

/// generated route for
/// [FilterPage]
class FilterRoute extends PageRouteInfo<FilterRouteArgs> {
  FilterRoute({
    Key? key,
    List<Facet> facets = const [],
    List<PageRouteInfo>? children,
  }) : super(
          FilterRoute.name,
          args: FilterRouteArgs(
            key: key,
            facets: facets,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static const PageInfo<FilterRouteArgs> page = PageInfo<FilterRouteArgs>(name);
}

class FilterRouteArgs {
  const FilterRouteArgs({
    this.key,
    this.facets = const [],
  });

  final Key? key;

  final List<Facet> facets;

  @override
  String toString() {
    return 'FilterRouteArgs{key: $key, facets: $facets}';
  }
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
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    required Function onLoginAttempt,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onLoginAttempt: onLoginAttempt,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onLoginAttempt,
  });

  final Key? key;

  final Function onLoginAttempt;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginAttempt: $onLoginAttempt}';
  }
}

/// generated route for
/// [MyAccountPage]
class MyAccountRoute extends PageRouteInfo<void> {
  const MyAccountRoute({List<PageRouteInfo>? children})
      : super(
          MyAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyAccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewAddressPage]
class NewAddressRoute extends PageRouteInfo<void> {
  const NewAddressRoute({List<PageRouteInfo>? children})
      : super(
          NewAddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewAddressRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderConfirmationPage]
class OrderConfirmationRoute extends PageRouteInfo<void> {
  const OrderConfirmationRoute({List<PageRouteInfo>? children})
      : super(
          OrderConfirmationRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderConfirmationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderListPage]
class OrderListRoute extends PageRouteInfo<void> {
  const OrderListRoute({List<PageRouteInfo>? children})
      : super(
          OrderListRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductDetailPage]
class ProductDetailRoute extends PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    Key? key,
    required String productId,
    List<PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'productId': productId},
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static const PageInfo<ProductDetailRouteArgs> page =
      PageInfo<ProductDetailRouteArgs>(name);
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.productId,
  });

  final Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, productId: $productId}';
  }
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
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchProductPage]
class SearchProductRoute extends PageRouteInfo<SearchProductRouteArgs> {
  SearchProductRoute({
    Key? key,
    String? searchTerm,
    List<PageRouteInfo>? children,
  }) : super(
          SearchProductRoute.name,
          args: SearchProductRouteArgs(
            key: key,
            searchTerm: searchTerm,
          ),
          rawQueryParams: {'searchTerm': searchTerm},
          initialChildren: children,
        );

  static const String name = 'SearchProductRoute';

  static const PageInfo<SearchProductRouteArgs> page =
      PageInfo<SearchProductRouteArgs>(name);
}

class SearchProductRouteArgs {
  const SearchProductRouteArgs({
    this.key,
    this.searchTerm,
  });

  final Key? key;

  final String? searchTerm;

  @override
  String toString() {
    return 'SearchProductRouteArgs{key: $key, searchTerm: $searchTerm}';
  }
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

/// generated route for
/// [SortPage]
class SortRoute extends PageRouteInfo<SortRouteArgs> {
  SortRoute({
    Key? key,
    List<Sort> sorts = const [],
    List<PageRouteInfo>? children,
  }) : super(
          SortRoute.name,
          args: SortRouteArgs(
            key: key,
            sorts: sorts,
          ),
          initialChildren: children,
        );

  static const String name = 'SortRoute';

  static const PageInfo<SortRouteArgs> page = PageInfo<SortRouteArgs>(name);
}

class SortRouteArgs {
  const SortRouteArgs({
    this.key,
    this.sorts = const [],
  });

  final Key? key;

  final List<Sort> sorts;

  @override
  String toString() {
    return 'SortRouteArgs{key: $key, sorts: $sorts}';
  }
}
