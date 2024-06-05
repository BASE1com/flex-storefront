import 'package:flex_storefront/checkout/cubits/delivery_mode_selection_cubit.dart';
import 'package:flex_storefront/checkout/cubits/delivery_mode_selection_state.dart';
import 'package:flex_storefront/flex_ui/widgets/rounded_card.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DeliveryModeSelectionCard extends StatelessWidget {
  DeliveryModeSelectionCard({super.key});

  final _formKey = GlobalKey<FormBuilderState>(
    debugLabel: 'delivery_mode_form',
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryModeSelectionCubit, DeliveryModeSelectionState>(
        builder: (context, state) {
      switch (state.status) {
        case Status.success:
          return RoundedCard(
            padding: const EdgeInsets.all(0),
            child: FormBuilder(
              key: _formKey,
              onChanged: () {
                final code =
                    _formKey.currentState!.instantValue['deliveryMode'];
                BlocProvider.of<DeliveryModeSelectionCubit>(context)
                    .changeDeliveryMode(code);
              },
              child: FormBuilderRadioGroup<String>(
                name: 'deliveryMode',
                initialValue: state.selectedCode,
                orientation: OptionsOrientation.vertical,
                decoration: const InputDecoration(border: InputBorder.none),
                options: state.deliveryModes
                    .map(
                      (d) => FormBuilderFieldOption(
                        value: d.code,
                        child: Text(
                          '${d.name} ${d.description != null ? '(${d.description})' : ''}',
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    });
  }
}
