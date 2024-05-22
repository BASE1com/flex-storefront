import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

enum CartInfoType {
  info(
    cardColor: FlexColors.info,
    textColor: FlexColors.onInfo,
  ),
  success(
    cardColor: FlexColors.success,
    textColor: FlexColors.onSuccess,
  ),
  warning(
    cardColor: FlexColors.warning,
    textColor: FlexColors.onWarning,
  ),
  error(
    cardColor: FlexColors.error,
    textColor: FlexColors.onError,
  );

  const CartInfoType({
    required this.cardColor,
    required this.textColor,
  });

  final Color cardColor;
  final Color textColor;
}

class CartInfoCard extends StatelessWidget {
  const CartInfoCard({
    super.key,
    this.type = CartInfoType.info,
    required this.message,
  });

  final CartInfoType type;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: type.cardColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(FlexSizes.md),
        child: Row(
          children: [
            Text(
              message,
              style: TextStyle(color: type.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
