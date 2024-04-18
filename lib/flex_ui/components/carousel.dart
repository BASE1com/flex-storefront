import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class FlexCarousel extends StatelessWidget {
  const FlexCarousel({
    super.key,
    this.height = 270,
    this.items,
  });

  final double height;
  final List<Widget>? items;

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: height,
        showIndicator: true,
        floatingIndicator: true,
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: Theme.of(context).primaryColor,
          indicatorBackgroundColor: Colors.white.withOpacity(0.7),
        ),
      ),
      items: items,
    );
  }
}
