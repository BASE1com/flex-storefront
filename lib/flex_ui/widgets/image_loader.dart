import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({super.key, this.aspectRatio});

  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    Widget widget = Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        color: Colors.grey[100]!,
      ),
    );

    if (aspectRatio != null) {
      widget = AspectRatio(
        aspectRatio: aspectRatio!,
        child: widget,
      );
    }

    return widget;
  }
}
