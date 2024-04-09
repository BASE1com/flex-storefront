import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_storefront/flex_ui/widgets/image_error.dart';
import 'package:flex_storefront/flex_ui/widgets/image_loader.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.url,
    this.fit,
    this.placeholderAspectRatio,
  });

  final String? url;
  final BoxFit? fit;

  /// If the widget size is not constrained by the parent, this param is
  /// necessary to provide a minimum size otherwise the loading/error widget
  /// will be ugly (or invisible if it's just a Container)
  ///
  /// It is not apply to the image itself because when the widget size is not
  /// constrained, we want the image to use its natural aspect ratio.
  ///
  /// If you want the image itself to be constrained, wrap this whole widget by
  /// AspectRatio (or SizedBox, Expanded, etc.) and use the fit param to
  /// specifiy how the image should layout.
  final double? placeholderAspectRatio;

  @override
  Widget build(BuildContext context) {
    // url could come as empty or 'null' depending on how it is declared
    if (url == null || url == '' || url == 'null') {
      return ImageError(
        aspectRatio: placeholderAspectRatio,
      );
    }

    if (!url!.startsWith('http')) {
      return Image.asset(
        url!,
        fit: fit,
        errorBuilder: (context, error, stacktrace) => ImageError(
          aspectRatio: placeholderAspectRatio,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: url!,
      placeholder: (context, url) => ImageLoader(
        aspectRatio: placeholderAspectRatio,
      ),
      errorWidget: (context, url, error) => ImageError(
        aspectRatio: placeholderAspectRatio,
      ),
      fit: fit,
    );
  }
}
