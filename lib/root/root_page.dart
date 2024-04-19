import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/router.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ShopRoute(),
        AccountRoute(),
        CartRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (index) {
              tabsRouter.setActiveIndex(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(LineAwesome.home_solid),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(LineAwesome.tag_solid),
                label: 'Shop',
              ),
              NavigationDestination(
                icon: Icon(LineAwesome.user_solid),
                label: 'Account',
              ),
              NavigationDestination(
                icon: Icon(LineAwesome.shopping_bag_solid),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
