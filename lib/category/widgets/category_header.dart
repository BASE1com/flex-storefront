import 'package:flex_storefront/category/models/category.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FlexSizes.appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              category.name,
              style: Theme.of(context).textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          RoundedImage(
            imageUrl: category.image?.url ??
                'https://picsum.photos/240/240?random=${category.id}',
            height: FlexSizes.imageThumbSize,
            borderRadius: FlexSizes.circleRadius,
          ),
        ],
      ),
    );
  }
}
