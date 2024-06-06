import 'package:collection/collection.dart';
import 'package:flex_storefront/checkout/cubits/address_selection_cubit.dart';
import 'package:flex_storefront/checkout/cubits/address_selection_state.dart';
import 'package:flex_storefront/checkout/models/address.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class AddressSelectionCard extends StatelessWidget {
  const AddressSelectionCard({
    super.key,
    required this.onAdd,
  });

  final VoidCallback onAdd;

  Future<Address?> _showAddressSelection(
    BuildContext context,
    List<Address> addresses,
    String? selectedId,
  ) async {
    return showDialog<Address>(
        context: context,
        builder: (_) {
          return SimpleDialog(
            title: const Text('Select address'),
            children: addresses
                .map(
                  (a) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, a);
                    },
                    child: Row(
                      children: [
                        Expanded(child: Text(a.multiLineFormat)),
                        if (a.id == selectedId)
                          const Icon(LineAwesome.check_solid),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressSelectionCubit, AddressSelectionState>(
      builder: (context, state) {
        if (state.status == Status.pending) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final address = state.addresses.firstWhereOrNull(
          (a) => a.id == state.selectedId,
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            address != null
                ? Text(address.multiLineFormat)
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: () async {
                final address = await _showAddressSelection(
                    context, state.addresses, state.selectedId);

                if (address != null) {
                  BlocProvider.of<AddressSelectionCubit>(context)
                      .changeAddress(address.id!);
                }
              },
              child: Text(address != null ? 'Change' : 'Add'),
            ),
          ],
        );
      },
    );
  }
}
