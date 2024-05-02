import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductListItemShimmer extends StatelessWidget {
  const ProductListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(FlexSizes.md),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: 108.0,
                  height: 108.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: FlexSizes.spacerItems),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // product name
                    Container(
                      width: double.infinity,
                      height: FlexSizes.fontSizeMd,
                      color: Colors.white,
                    ),
                    const SizedBox(height: FlexSizes.sm),
                    Container(
                      width: 72,
                      height: FlexSizes.fontSizeSm,
                      color: Colors.white,
                    ),
                    const SizedBox(height: FlexSizes.sm),
                    Container(
                      width: 84,
                      height: FlexSizes.fontSizeSm,
                      color: Colors.white,
                    ),
                    const SizedBox(height: FlexSizes.sm),
                    Container(
                      width: 120,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
