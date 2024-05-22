import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

enum CartInfoType {
  info,
  success,
  warning,
  error,
}

class CartInfoCard extends StatelessWidget {
  const CartInfoCard({
    super.key,
    this.type = CartInfoType.info,
    required this.message,
  });

  final CartInfoType type;
  final String message;

  Color getCardColor() {
    switch (type) {
      case CartInfoType.success:
        return FlexColors.success;
      case CartInfoType.warning:
        return FlexColors.warning;
      case CartInfoType.error:
        return FlexColors.error;
      case CartInfoType.info:
      default:
        return FlexColors.info;
    }
  }

  Color getTextColor() {
    switch (type) {
      case CartInfoType.success:
        return FlexColors.onSuccess;
      case CartInfoType.warning:
        return FlexColors.onWarning;
      case CartInfoType.error:
        return FlexColors.onError;
      case CartInfoType.info:
      default:
        return FlexColors.onInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getCardColor(),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(FlexSizes.md),
        child: Row(
          children: [
            Text(
              message,
              style: TextStyle(color: getTextColor()),
            ),
          ],
        ),
      ),
    );
  }
}
