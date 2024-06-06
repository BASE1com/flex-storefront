import 'package:auto_route/annotations.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrderConfirmationView();
  }
}

class OrderConfirmationView extends StatelessWidget {
  const OrderConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: FlexAppBar(
        showSearchButton: false,
        showBackArrow: true,
        leadingIcon: LineAwesome.times_solid,
        title: Text('Order Confirmation'),
      ),
      body: Center(
        child: Text('Thank you for your order'),
      ),
    );
  }
}
