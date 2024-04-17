import 'package:flex_storefront/flex_ui/components/product_gallery.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/add_to_cart_button.dart';
import 'package:flex_storefront/flex_ui/widgets/product_price.dart';
import 'package:flex_storefront/flex_ui/widgets/quantity_selector.dart';
import 'package:flex_storefront/flex_ui/widgets/star_rating.dart';
import 'package:flex_storefront/product_detail/cubits/product_detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final product =
        context.select((ProductDetailCubit bloc) => bloc.state.product)!;
    final quantity =
        context.select((ProductDetailCubit bloc) => bloc.state.quantity);

    final galleryImages = product.galleryImages;
    final galleryThumbnails = product.galleryThumbnails;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Product Image Carousel
          FlexProductGallery(
            imageUrls: galleryImages.map((e) => e.fullUrl).toList(),
            thumbnailUrls: galleryThumbnails.map((e) => e.fullUrl).toList(),
            borderRadius: FlexSizes.borderRadiusSm,
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${product.manufacturer}',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8.0),
                StarRating(
                  rating: product.averageRating ?? 0,
                  size: 24,
                  showRating: true,
                ),
                const SizedBox(height: 8.0),
                if (product.price != null)
                  ProductPrice(
                    price: product.price!,
                  ),
                const SizedBox(height: 8.0),
                const Divider(height: 16.0),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                QuantitySelector(
                  quantity: quantity,
                  onChanged: (val) => context
                      .read<ProductDetailCubit>()
                      .changeQuantity(quantity: val),
                ),
                const SizedBox(width: 16.0),
                const AddToCartButton(),
              ],
            ),
          ),
          const Divider(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Description',
                  textAlign: TextAlign.left,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                SelectionArea(
                  child: Text(
                    product.description!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
