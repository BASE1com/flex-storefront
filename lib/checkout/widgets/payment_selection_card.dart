import 'package:collection/collection.dart';
import 'package:flex_storefront/checkout/cubits/payment_selection_cubit.dart';
import 'package:flex_storefront/checkout/cubits/payment_selection_state.dart';
import 'package:flex_storefront/checkout/models/payment_info.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_card.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class PaymentSelectionCard extends StatelessWidget {
  const PaymentSelectionCard({
    super.key,
  });

  Future<PaymentInfo?> _showPaymentSelection(
    BuildContext context,
    List<PaymentInfo> payments,
    String? selectedId,
  ) async {
    return showDialog<PaymentInfo>(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text('Select payment'),
          children: payments
              .map(
                (p) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, p);
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text(p.multiLineDisplay)),
                      if (p.id == selectedId)
                        const Icon(LineAwesome.check_solid),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentSelectionCubit, PaymentSelectionState>(
      builder: (context, state) {
        if (state.status == Status.pending) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final payment = state.payments.firstWhereOrNull(
          (p) => p.id == state.selectedId,
        );

        return RoundedCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (payment != null) Text(payment.multiLineDisplay),
              if (payment?.cardType.code == 'visa')
                const Icon(LineAwesome.cc_visa),
              if (payment?.cardType.code == 'master')
                const Icon(LineAwesome.cc_mastercard),
              const Expanded(child: SizedBox.shrink()),
              OutlinedButton(
                onPressed: () async {
                  final payment = await _showPaymentSelection(
                      context, state.payments, state.selectedId);

                  if (payment != null && context.mounted) {
                    BlocProvider.of<PaymentSelectionCubit>(context)
                        .changePaymentInfo(payment.id);
                  }
                },
                child: Text(payment != null ? 'Change' : 'Add'),
              ),
            ],
          ),
        );
      },
    );
  }
}
