import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class FlexAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: FlexColors.primary,
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
        color: FlexColors.onPrimary,
      ),
    ),
    brightness: Brightness.light,
    primaryColor: FlexColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: Typography.blackHelsinki,
    searchBarTheme: SearchBarThemeData(
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
    searchBarTheme: SearchBarThemeData(
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FlexSizes.inputFieldRadius),
        ),
      ),
    ),
  );
}
