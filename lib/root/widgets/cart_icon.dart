import 'package:badges/badges.dart';
import 'package:flex_storefront/cart/cubits/cart_icon_cubit.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final count =
        context.select((CartIconCubit cubit) => cubit.state.totalItems);

    return Badge(
      position: BadgePosition.topEnd(top: -12, end: -16),
      badgeContent: Text(
        count.toString(),
        style: const TextStyle(
          fontSize: FlexSizes.fontSizeXs,
          color: Colors.white,
        ),
      ),
      badgeAnimation: const BadgeAnimation.scale(
        curve: Curves.fastOutSlowIn,
      ),
      child: const Icon(LineAwesome.shopping_bag_solid),
    );
  }
}
