import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/flex_ui/widgets/selectable_image.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class FlexCarousel extends StatelessWidget {
  const FlexCarousel({
    super.key,
    this.height = 270,
    this.items,
    this.floatingIndicator = true,
  });

  final double height;
  final List<Widget>? items;
  final bool floatingIndicator;

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: height,
        showIndicator: true,
        floatingIndicator: floatingIndicator,
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: FlexColors.primary,
          indicatorBackgroundColor:
              floatingIndicator ? Colors.white.withOpacity(0.7) : Colors.grey,
        ),
      ),
      items: items,
    );
  }
}

class FlexCarouselShimmer extends StatelessWidget {
  const FlexCarouselShimmer({
    super.key,
    this.height = 132,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FlexSizes.appPadding,
        vertical: FlexSizes.sm,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(FlexSizes.borderRadiusLg),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: FlexCarousel,
)
Widget defaultCarousel(BuildContext context) {
  return Center(
    child: FlexCarousel(
      height: context.knobs.double.input(label: 'Height', initialValue: 250),
      items: List.generate(
        context.knobs.int.slider(label: 'Item count', initialValue: 3),
        (index) => SelectableImage(
          imageUrl: 'https://picsum.photos/350/262?random=$index',
          borderRadius: FlexSizes.borderRadiusMd,
        ),
      ),
    ),
  );
}
