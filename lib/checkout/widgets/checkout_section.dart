import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class CheckoutSection extends StatelessWidget {
  const CheckoutSection({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: FlexSizes.sm),
        content,
      ],
    );
  }
}
