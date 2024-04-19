import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryCircle extends StatelessWidget {
  const CategoryCircle({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onPressed,
  });

  final String title;
  final String imageUrl;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          ClipOval(
            child: CachedImage(url: imageUrl),
          ),
          const SizedBox(height: FlexSizes.spacerItems),
          Text(
            title,
            style: const TextStyle(
              fontSize: FlexSizes.fontSizeSm,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
