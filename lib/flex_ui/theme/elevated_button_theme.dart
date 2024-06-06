import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class FlexElevatedButtonTheme {
  FlexElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: FlexColors.onSecondary,
      backgroundColor: FlexColors.secondary,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: FlexColors.secondary),
      padding: const EdgeInsets.all(FlexSizes.md),
      textStyle: const TextStyle(
        fontSize: FlexSizes.fontSizeSm,
        color: FlexColors.onSecondary,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FlexSizes.borderRadiusSm),
      ),
    ),
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: FlexColors.onSecondary,
      backgroundColor: FlexColors.secondary,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: FlexColors.secondary),
      padding: const EdgeInsets.all(FlexSizes.md),
      textStyle: const TextStyle(
        fontSize: FlexSizes.fontSizeSm,
        color: FlexColors.onSecondary,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FlexSizes.borderRadiusSm),
      ),
    ),
  );
}
