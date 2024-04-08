import 'package:flutter/material.dart';

/// A widget that displays a row of stars with a specified count and rating.
class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = 0.0,
    this.color = Colors.orangeAccent,
    this.size = 30,
    this.showRating = false,
  });

  /// The total number of stars in the rating.
  ///
  /// Defaults to `5`.
  final int starCount;

  /// The current rating value.
  ///
  /// Defaults to `0.0`.
  final double rating;

  /// The color of the stars.
  ///
  /// Defaults to `Colors.orangeAccent`.
  final Color? color;

  /// The size of the stars.
  ///
  /// Defaults to `30`.
  final double size;

  /// If `true`, will display the rating as text.
  ///
  /// Defaults to `false`.
  final bool showRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          starCount,
          (index) {
            return index < rating
                ? Icon(
                    Icons.star,
                    size: size,
                    color: color,
                  )
                : Icon(
                    Icons.star_border,
                    size: size,
                    color: Colors.grey[400],
                  );
          },
        ),
        if (showRating) ...[
          const SizedBox(width: 6),
          Text(
            rating.toString(),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.apply(color: Colors.grey),
          ),
        ],
      ],
    );
  }
}
