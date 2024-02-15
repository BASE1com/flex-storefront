import 'package:flex_storefront/home/home_page.dart';
import 'package:flex_storefront/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flex Storefront',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
