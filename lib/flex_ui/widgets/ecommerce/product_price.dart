import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/product_list/models/price.dart';
import 'package:flutter/material.dart';

enum ProductPriceType {
  detail(
    TextStyle(
      fontSize: 24,
      color: Colors.green,
      fontWeight: FontWeight.bold,
    ),
  ),
  list(
    TextStyle(
      fontSize: FlexSizes.fontSizeMd,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    ),
  );

  const ProductPriceType(this.style);

  final TextStyle style;
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
    required this.type,
  });

  final Price price;
  final ProductPriceType type;

  @override
  Widget build(BuildContext context) {
    // TODO: Handle product is on sale

    // Price known
    return Text(
      price.formattedValue,
      style: type.style,
    );

    // TODO: Handle Price unknown or price ranges
  }
}
