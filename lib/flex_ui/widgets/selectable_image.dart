import 'package:flex_storefront/flex_ui/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class SelectableImage extends StatelessWidget {
  const SelectableImage({
    super.key,
    required this.url,
    this.fit,
    this.aspectRatio,
    required this.selected,
    this.onTap,
  });

  final String? url;
  final BoxFit? fit;
  final double? aspectRatio;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.blue : Colors.transparent,
          ),
        ),
        child: CachedImage(
          url: url,
          fit: fit,
          placeholderAspectRatio: aspectRatio,
        ),
      ),
    );
  }
}
