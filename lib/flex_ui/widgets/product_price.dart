import 'package:flex_storefront/product_list/models/price.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
  });

  final Price price;

  @override
  Widget build(BuildContext context) {
    // TODO: Handle product is on sale

    // Price known
    return Text(
      price.formattedValue,
      style: const TextStyle(
        fontSize: 24,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );

    // TODO: Handle Price unknown or price ranges
  }
}
