import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flex_storefront/cms/models/cms_models.dart';
import 'package:flex_storefront/flex_ui/components/carousel.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flex_storefront/flex_ui/widgets/selectable_image.dart';
import 'package:flex_storefront/product_list/cubits/product_list_cubit.dart';
import 'package:flex_storefront/product_list/cubits/product_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePageContent extends StatelessWidget {
  final List<CmsData> sections;

  const HomePageContent({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    final widgets = sections.map((section) {
      if (section is SpacerData) {
        return SizedBox(height: section.space);
      } else if (section is HeaderData) {
        return Text(
          section.text,
          style: const TextStyle(
            fontSize: FlexSizes.fontSizeLg,
            fontWeight: FontWeight.w600,
          ),
        );
      } else if (section is BannerData) {
        return SelectableImage(
          aspectRatio: section.aspectRatio,
          imageUrl: section.banner.url,
          borderRadius: FlexSizes.borderRadiusMd,
          onTap: () {
            context.router.navigateNamed(section.link);
          },
        );
      } else if (section is CarouselData) {
        return FlexCarousel(
          height: section.aspectRatio,
          items: section.items.map((item) {
            return SelectableImage(
              aspectRatio: section.aspectRatio,
              imageUrl: item.media.url,
              borderRadius: FlexSizes.borderRadiusMd,
              onTap: () {
                context.router.navigateNamed(item.link);
              },
            );
          }).toList(),
        );
      } else if (section is ProductCarouselData) {
        return BlocProvider<ProductListCubit>(
          create: (_) => ProductListCubit()
            ..loadProductsfromIds(productIds: section.productCodes),
          child: BlocBuilder<ProductListCubit, ProductListState>(
              builder: (context, state) {
            return FlexCarousel(
              floatingIndicator: false,
              items: section.productCodes.map((code) {
                final product =
                    state.products.firstWhereOrNull((p) => p.code == code);

                if (product != null) {
                  return InkWell(
                    onTap: () {
                      context.router.navigateNamed('/shop/product/$code');
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: CachedImage(
                            url:
                                '${dotenv.get('HYBRIS_BASE_URL')}${product.images.firstOrNull?.url}',
                            fit: BoxFit.contain,
                            placeholderAspectRatio: 1,
                          ),
                        ),
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(product.price!.formattedValue),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: 300,
                    width: 400,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }).toList(),
            );
          }),
        );
      } else {
        // TODO GetItfy Crashlytics and log exception
        return const SizedBox.shrink();
      }
    }).toList();

    return Column(
      children: [
        const SizedBox(height: FlexSizes.spacerItems),
        ...widgets,
      ],
    );
  }
}
