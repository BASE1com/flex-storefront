import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class FlexGridLayout extends StatelessWidget {
  const FlexGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 200,
    this.crossAxisCount = 3,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final double mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: FlexSizes.gridViewSpacing,
        crossAxisSpacing: FlexSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: FlexSizes.lg),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
