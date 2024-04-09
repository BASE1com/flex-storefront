import 'package:flex_storefront/flex_ui/widgets/add_to_cart_button.dart';
import 'package:flex_storefront/flex_ui/widgets/star_rating.dart';
import 'package:flex_storefront/product_list/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        // TODO: Navigate to product detail page
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Image.network(
                '${dotenv.get('HYBRIS_BASE_URL')}${product.images.first.url}',
                fit: BoxFit.contain,
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
