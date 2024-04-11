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
        CachedImage(
          url:
              '${dotenv.get('HYBRIS_BASE_URL')}${entry.product.cartImage?.url}',
          placeholderAspectRatio: 1,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.product.name),
              const SizedBox(height: 8),
              if (showPrice) Text(entry.product.price?.formattedValue ?? ''),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
