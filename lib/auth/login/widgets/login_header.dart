import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/shared/utils/image_strings.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FlexSizes.appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CachedImage(
            height: FlexSizes.imageThumbSize * 0.75,
            url: FlexImages.logo,
            placeholder: SizedBox.shrink(),
            error: SizedBox.shrink(),
          ),
          const SizedBox(height: FlexSizes.spacerItems),
          Text(
            'Login',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: FlexSizes.xs),
          Text(
            'Please sign in to continue',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
