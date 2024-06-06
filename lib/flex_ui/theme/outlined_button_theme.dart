import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class FlexOutlinedButtonTheme {
  FlexOutlinedButtonTheme._();

  static OutlinedButtonThemeData lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: FlexColors.secondary,
      side: const BorderSide(color: FlexColors.secondary),
      padding: const EdgeInsets.all(FlexSizes.md),
      textStyle: const TextStyle(
        fontSize: FlexSizes.fontSizeSm,
        color: FlexColors.secondary,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FlexSizes.borderRadiusSm),
      ),
    ),
  );

  static OutlinedButtonThemeData darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: FlexColors.secondary,
      side: const BorderSide(color: FlexColors.secondary),
      padding: const EdgeInsets.all(FlexSizes.md),
      textStyle: const TextStyle(
        fontSize: FlexSizes.fontSizeSm,
        color: FlexColors.secondary,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FlexSizes.borderRadiusSm),
      ),
    ),
  );
}
