import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.color,
    this.size = 48,
    this.disabled = false,
  }) : assert(size >= 36, 'Minimum of `36` size.');

  final int quantity;
  final ValueChanged<int> onChanged;
  final Color? color;
  final double size;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final decreaseButton = Material(
      color: disabled
          ? Theme.of(context).disabledColor
          : (color ?? Theme.of(context).colorScheme.secondary),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(4),
        bottomLeft: Radius.circular(4),
      ),
      child: InkWell(
        onTap: disabled ? null : () => onChanged(quantity - 1),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            Icons.remove,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );

    final increaseButton = Material(
      color: disabled
          ? Colors.grey
          : (color ?? Theme.of(context).colorScheme.secondary),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(4),
        bottomRight: Radius.circular(4),
      ),
      child: InkWell(
        onTap: disabled ? null : () => onChanged(quantity + 1),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );

    final quantityWidget = Container(
      height: size,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Qty',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    return Row(
      children: [
        decreaseButton,
        quantityWidget,
        increaseButton,
      ],
    );
  }
}
