import 'package:badges/badges.dart' as badges;
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/root/cubit/cart_icon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final count =
        context.select((CartIconCubit cubit) => cubit.state.totalItems);

    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -12, end: -16),
      badgeContent: Text(
        count.toString(),
        style: const TextStyle(
          fontSize: FlexSizes.fontSizeXs,
          color: Colors.white,
        ),
      ),
      badgeAnimation: const badges.BadgeAnimation.slide(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      child: const Icon(LineAwesome.shopping_bag_solid),
    );
  }
}
