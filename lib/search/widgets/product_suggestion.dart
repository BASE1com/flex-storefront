import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/flex_ui/widgets/ecommerce/product_price.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flex_storefront/search/utils/emphasis_parsing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductSuggestion extends StatelessWidget with EmphasisParsing {
  const ProductSuggestion({
    super.key,
    required this.product,
    this.padding = EdgeInsets.zero,
  });

  final Product product;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.maybePop();
        context.router.navigateNamed('/shop/product/${product.code}');
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            CachedImage(
              url:
                  '${dotenv.get('HYBRIS_BASE_URL')}${product.images.firstOrNull?.url}',
              fit: BoxFit.contain,
              placeholderAspectRatio: 1,
              height: FlexSizes.imageThumbSizeSm,
            ),
            const SizedBox(width: FlexSizes.spacerItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  toRichText(product.name),
                  const SizedBox(height: FlexSizes.xs),
                  if (product.price != null)
                    ProductPrice(
                      price: product.price!,
                      type: ProductPriceType.list,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
