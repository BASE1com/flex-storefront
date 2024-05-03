import 'package:flex_storefront/cart/bloc/global_cart_bloc.dart';
import 'package:flex_storefront/flex_ui/theme/theme.dart';
import 'package:flex_storefront/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalCartBloc>(
      create: (context) => GlobalCartBloc(),
      child: MaterialApp.router(
        title: 'Flex Storefront',
        theme: FlexAppTheme.lightTheme,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
