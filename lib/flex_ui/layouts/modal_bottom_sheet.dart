import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

/// A simple implementation that uses a [Material] widget
/// to display a modal bottom sheet.
///
/// See https://github.com/Milad-Akarie/auto_route_library/issues/675
/// for a more advanced use case (with draggable/scrollable capability).
class FlexModalBottomSheet extends StatelessWidget {
  const FlexModalBottomSheet({
    super.key,
    required this.child,
    this.height,
    this.borderRadius = FlexSizes.borderRadiusLg,
  });

  final Widget child;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(borderRadius),
      ),
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.45,
        padding: const EdgeInsets.all(FlexSizes.appPadding),
        child: child,
      ),
    );
  }
}
