import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FlexAppBar(
        title: Text('My Account'),
      ),
      body: Center(child: Text('Account Page')),
    );
  }
}
