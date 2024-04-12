import 'package:flex_storefront/flex_ui/widgets/add_to_cart_button.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/flex_ui/widgets/product_price.dart';
import 'package:flex_storefront/flex_ui/widgets/quantity_selector.dart';
import 'package:flex_storefront/flex_ui/widgets/selectable_image.dart';
import 'package:flex_storefront/flex_ui/widgets/star_rating.dart';
import 'package:flex_storefront/product_detail/cubits/product_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailContent extends StatefulWidget {
  const ProductDetailContent({super.key});

  @override
  State<ProductDetailContent> createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<ProductDetailContent> {
  int _selectedImage = 0;

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
          AspectRatio(
            aspectRatio: 1,
            child: CachedImage(
              url: galleryImages.isNotEmpty
                  ? galleryImages[_selectedImage].fullUrl
                  : '',
              fit: BoxFit.contain,
            ),
          ),
          if (galleryThumbnails.length > 1)
            SizedBox(
              height: 100,
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                scrollDirection: Axis.horizontal,
                itemCount: galleryThumbnails.length,
                itemBuilder: (_, int index) {
                  return Padding(
                    padding: index != 0
                        ? const EdgeInsets.only(left: 8.0)
                        : EdgeInsets.zero,
                    child: SelectableImage(
                      url: galleryThumbnails[index].fullUrl,
                      fit: BoxFit.contain,
                      aspectRatio: 1,
                      selected: index == _selectedImage,
                      onTap: () {
                        setState(() {
                          _selectedImage = index;
                        });
                      },
                    ),
                  );
                },
              ),
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
