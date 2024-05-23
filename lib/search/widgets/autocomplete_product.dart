import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/flex_ui/widgets/ecommerce/product_price.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class AutocompleteProduct extends StatelessWidget {
  const AutocompleteProduct({
    super.key,
    required this.product,
    this.padding = EdgeInsets.zero,
  });

  final Product product;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final parsedHtml = parse(product.name);
    // TODO do the parsing once and for all, in constructor
    final productNameParts = parsedHtml.getElementsByTagName('body')[0].nodes;

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
              height: 64,
            ),
            const SizedBox(width: FlexSizes.spacerItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    maxLines: null, // Authorize multi-lines without limit
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: FlexSizes.fontSizeMd,
                      ),
                      children: productNameParts.map(
                        (node) {
                          final emphasis =
                              node is dom.Element && node.localName == 'em';

                          return TextSpan(
                            text: node.text,
                            style: TextStyle(
                              fontWeight: emphasis
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
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
