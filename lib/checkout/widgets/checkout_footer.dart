import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class CheckoutFooter extends StatelessWidget {
  const CheckoutFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            spreadRadius: 0.0,
            color: Colors.grey.shade400,
          ),
        ],
        color: Colors.white,
      ),
      child: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(FlexSizes.md),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Total'),
                  Text('\$134.02'),
                ],
              ),
              const SizedBox(height: FlexSizes.spacerItems),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
