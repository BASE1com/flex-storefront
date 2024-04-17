import 'package:flex_storefront/cart/models/cart.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CartEntryProduct extends StatelessWidget {
  const CartEntryProduct({
    super.key,
    required this.entry,
    this.showPrice = true,
  });

  final CartItem entry;
  final bool showPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 96,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200]!,
            ),
          ),
          child: CachedImage(
            url:
                '${dotenv.get('HYBRIS_BASE_URL')}${entry.product.productImage?.url}',
            fit: BoxFit.contain,
            placeholderAspectRatio: 1,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.product.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (entry.product.manufacturer != null)
                Text('by ${entry.product.manufacturer}'),
              const SizedBox(height: 8),
              Text(
                entry.totalPrice.formattedValue,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (showPrice)
                Text(
                  '${entry.basePrice.formattedValue} per item',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
