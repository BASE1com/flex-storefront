import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/add_to_cart_button.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/flex_ui/widgets/star_rating.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.navigateNamed('product/${product.code}');
      },
      child: Padding(
        padding: const EdgeInsets.all(FlexSizes.md),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: CachedImage(
                url:
                    '${dotenv.get('HYBRIS_BASE_URL')}${product.images.firstOrNull?.url}',
                fit: BoxFit.contain,
                placeholderAspectRatio: 1,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (product.averageRating != null)
                    StarRating(
                      rating: product.averageRating!,
                      size: 20,
                    ),
                  Text(product.price!.formattedValue),
                  if (product.description != null) Text(product.description!),
                  const SizedBox(height: 8),
                  const AddToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      ),
    );
  }
}
