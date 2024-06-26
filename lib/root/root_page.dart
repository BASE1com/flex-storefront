import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/analytics/widgets/analytics_cart_listener.dart';
import 'package:flex_storefront/cart/cubits/cart_icon_cubit.dart';
import 'package:flex_storefront/root/widgets/cart_icon.dart';
import 'package:flex_storefront/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      lazyLoad: false,
      routes: const [
        HomeRoute(),
        ShopRoute(),
        AccountRoute(),
        CartRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return AnalyticsCartListener(
          child: Scaffold(
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: tabsRouter.activeIndex,
              onDestinationSelected: (index) {
                tabsRouter.setActiveIndex(index);
              },
              destinations: [
                const NavigationDestination(
                  icon: Icon(LineAwesome.home_solid),
                  label: 'Home',
                ),
                const NavigationDestination(
                  icon: Icon(LineAwesome.tag_solid),
                  label: 'Shop',
                ),
                const NavigationDestination(
                  icon: Icon(LineAwesome.user_solid),
                  label: 'Account',
                ),
                NavigationDestination(
                  icon: BlocProvider(
                    create: (context) => CartIconCubit(),
                    child: const CartIcon(),
                  ),
                  label: 'Cart',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
