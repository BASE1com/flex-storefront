import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class FlexPill extends StatelessWidget {
  const FlexPill({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
    this.margin = const EdgeInsets.only(left: 8),
  });

  final String text;
  final bool isSelected;
  final void Function()? onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: FlexSizes.sm,
          horizontal: FlexSizes.md,
        ),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FlexSizes.borderRadiusMd),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.outline,
          ),
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
