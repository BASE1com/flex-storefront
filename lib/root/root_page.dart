import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/cart/bloc/global_cart_bloc.dart';
import 'package:flex_storefront/root/cubit/cart_icon_cubit.dart';
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
      routes: const [
        HomeRoute(),
        ShopRoute(),
        AccountRoute(),
        CartRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return BlocProvider<CartIconCubit>(
          create: (context) => CartIconCubit(
            globalCartBloc: context.read<GlobalCartBloc>(),
          ),
          child: Scaffold(
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
                  icon: CartIcon(),
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
