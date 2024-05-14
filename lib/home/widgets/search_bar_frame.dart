import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class SearchBarFrame extends StatelessWidget {
  const SearchBarFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.fromLTRB(
        FlexSizes.appPadding,
        FlexSizes.xs,
        FlexSizes.appPadding,
        FlexSizes.xs,
      ),
      child: child,
    );
  }
}
