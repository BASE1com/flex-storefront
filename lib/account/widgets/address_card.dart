import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(FlexSizes.md),
      margin: const EdgeInsets.only(bottom: FlexSizes.spacerItems),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(FlexSizes.cardRadiusSm),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: FlexSizes.xs,
            top: 0,
            child: Icon(
              address.defaultAddress ? Icons.check_circle : null,
              color: Colors.green,
            ),
          ),
          Text(address.multiLineFormat),
        ],
      ),
    );
  }
}
