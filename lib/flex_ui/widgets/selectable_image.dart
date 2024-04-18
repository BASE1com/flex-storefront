import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class SelectableImage extends StatelessWidget {
  const SelectableImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.padding,
    this.border,
    this.borderRadius = 0,
    this.fit = BoxFit.contain,
    this.aspectRatio,
    this.backgroundColor,
    this.selected = false,
    this.onTap,
  });

  final String imageUrl;
  final double? width, height;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit? fit;
  final double? aspectRatio;
  final Color? backgroundColor;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: CachedImage(
            url: imageUrl,
            fit: fit,
            placeholderAspectRatio: aspectRatio,
          ),
        ),
      ),
    );
  }
}
