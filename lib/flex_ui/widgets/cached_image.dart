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
    this.height,
    this.width,
    this.placeholder,
    this.error,
  });

  final String url;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? error;

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
  ///
  /// This property has not effect on the placeholder widget if [placeholder] is
  /// provided and/or the error widget if [error] is provided.
  final double? placeholderAspectRatio;

  @override
  Widget build(BuildContext context) {
    // url could come as empty or 'null' depending on how it is declared
    if (url == '' || url == 'null') {
      return error ??
          ImageError(
            aspectRatio: placeholderAspectRatio,
          );
    }

    if (!url.startsWith('http')) {
      return Image.asset(
        url,
        fit: fit,
        errorBuilder: (context, err, stacktrace) =>
            error ??
            ImageError(
              aspectRatio: placeholderAspectRatio,
            ),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) =>
          placeholder ??
          ImageLoader(
            aspectRatio: placeholderAspectRatio,
          ),
      errorWidget: (context, url, err) =>
          error ??
          ImageError(
            aspectRatio: placeholderAspectRatio,
          ),
      fit: fit,
      height: height,
      width: width,
    );
  }
}
