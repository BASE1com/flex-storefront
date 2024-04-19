import 'package:flex_storefront/flex_ui/theme/theme.dart';
import 'package:flex_storefront/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flex Storefront',
      theme: FlexAppTheme.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
