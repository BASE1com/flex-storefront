import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class CheckoutSection extends StatelessWidget {
  const CheckoutSection({
    super.key,
    required this.title,
    required this.content,
    this.pending = false,
    this.invalid = false,
    this.invalidMessage,
  });

  final String title;
  final Widget content;
  final bool pending;
  final bool invalid;
  final String? invalidMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: FlexSizes.xs),
        pending
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : content,
        if (invalid)
          Text(
            invalidMessage!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          )
      ],
    );
  }
}
