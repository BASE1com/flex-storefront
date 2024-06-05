import 'package:flex_storefront/checkout/models/payment_info.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PaymentSelectionCard extends StatelessWidget {
  const PaymentSelectionCard({
    super.key,
    this.paymentInfo,
    required this.onAdd,
    required this.onChange,
  });

  final PaymentInfo? paymentInfo;
  final VoidCallback onAdd;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Row(
        children: [
          if (paymentInfo == null) const Text('Select a payment method'),
          if (paymentInfo != null) ...[
            Column(
              children: [
                Text(paymentInfo!.accountHolderName),
                Text(paymentInfo!.cardNumber),
                Text(
                  'Expires: ${paymentInfo!.expiryMonth.padLeft(2, '0')}/${paymentInfo!.expiryYear}',
                ),
              ],
            ),
            if (paymentInfo!.cardType.code == 'visa')
              const Icon(LineAwesome.cc_visa),
            if (paymentInfo!.cardType.code == 'mastercard')
              const Icon(LineAwesome.cc_mastercard),
          ],
          const Expanded(child: SizedBox.shrink()),
          ElevatedButton(
            onPressed: paymentInfo != null ? onChange : onAdd,
            child: Text(paymentInfo != null ? 'Change' : 'Add'),
          ),
        ],
      ),
    );
  }
}
