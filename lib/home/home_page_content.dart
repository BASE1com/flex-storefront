import 'package:flex_storefront/cms/models/cms_models.dart';
import 'package:flex_storefront/flex_ui/components/carousel.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/selectable_image.dart';
import 'package:flutter/material.dart';

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
        );
      } else if (section is CarouselData) {
        return FlexCarousel(
          height: section.aspectRatio,
          items: section.items.map((item) {
            return SelectableImage(
              aspectRatio: section.aspectRatio,
              imageUrl: item.media.url,
              borderRadius: FlexSizes.borderRadiusMd,
            );
          }).toList(),
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
