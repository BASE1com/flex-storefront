import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = 0.0,
    this.color = Colors.orangeAccent,
    this.size = 30,
    this.showRating = false,
  });

  final int starCount;
  final double rating;
  final Color? color;
  final double size;
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
            rating.toStringAsFixed(1), // TODO: this should be configurable
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
