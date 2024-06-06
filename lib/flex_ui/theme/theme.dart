import 'package:flex_storefront/flex_ui/theme/elevated_button_theme.dart';
import 'package:flex_storefront/flex_ui/theme/outlined_button_theme.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class FlexAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.black, size: FlexSizes.iconMd),
      actionsIconTheme:
          IconThemeData(color: Colors.black, size: FlexSizes.iconMd),
      titleTextStyle: TextStyle(
        fontSize: FlexSizes.fontSizeXl,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    brightness: Brightness.light,
    primaryColor: FlexColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: Typography.blackHelsinki,
    elevatedButtonTheme: FlexElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: FlexOutlinedButtonTheme.lightOutlinedButtonTheme,
    searchBarTheme: SearchBarThemeData(
      elevation: const MaterialStatePropertyAll(0),
      side: const MaterialStatePropertyAll(
        BorderSide(color: FlexColors.primary),
      ),
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FlexSizes.inputFieldRadius),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.black, size: FlexSizes.iconMd),
      actionsIconTheme:
          IconThemeData(color: Colors.black, size: FlexSizes.iconMd),
      titleTextStyle: TextStyle(
        fontSize: FlexSizes.fontSizeXl,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    brightness: Brightness.dark,
    primaryColor: FlexColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: Typography.blackHelsinki,
    elevatedButtonTheme: FlexElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: FlexOutlinedButtonTheme.darkOutlinedButtonTheme,
    searchBarTheme: SearchBarThemeData(
      elevation: const MaterialStatePropertyAll(0),
      side: const MaterialStatePropertyAll(
        BorderSide(color: FlexColors.primary),
      ),
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FlexSizes.inputFieldRadius),
        ),
      ),
    ),
  );
}
