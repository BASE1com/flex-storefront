import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    this.title = 'Add to Cart',
    this.onPressed,
    this.dense = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: dense
          ? ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: FlexSizes.md,
                  vertical: FlexSizes.sm,
                ),
              ),
            )
          : null,
      onPressed: onPressed,
      child: const Text('Add to Cart'),
    );
  }
}

@widgetbook.UseCase(
  name: 'Enabled',
  type: AddToCartButton,
)
Widget enabledButton(BuildContext context) {
  return Center(
    child: AddToCartButton(
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'Disabled',
  type: AddToCartButton,
)
Widget disabledButton(BuildContext context) {
  return const Center(
    child: AddToCartButton(),
  );
}
