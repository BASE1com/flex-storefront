import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flutter/material.dart';

class AddressSelectionCard extends StatelessWidget {
  const AddressSelectionCard({
    super.key,
    this.address,
    required this.onAdd,
    required this.onChange,
  });

  final Address? address;
  final VoidCallback onAdd;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        address != null
            ? Text(address!.multiLineFormat)
            : const SizedBox.shrink(),
        ElevatedButton(
          onPressed: address != null ? onChange : onAdd,
          child: Text(address != null ? 'Change' : 'Add'),
        ),
      ],
    );
  }
}
