import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/addresses/cubits/address_form_cubit.dart';
import 'package:flex_storefront/account/addresses/cubits/address_form_state.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class NewAddressPage extends StatelessWidget {
  const NewAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressFormCubit()..loadCountries(),
      child: Scaffold(
        appBar: const FlexAppBar(
          showBackArrow: true,
          leadingIcon: Icons.close,
          showSearchButton: false,
          title: Text('New shipping address'),
        ),
        body: NewAddressForm(),
      ),
    );
  }
}

class NewAddressForm extends StatelessWidget {
  NewAddressForm({super.key});

  final _formKey = GlobalKey<FormBuilderState>(debugLabel: 'new_address_form');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressFormCubit, AddressFormState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(FlexSizes.appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // country
                  FormBuilderDropdown(
                    name: 'countryIsoCode',
                    items: state.countries
                        .map((e) => DropdownMenuItem(
                            value: e.isocode, child: Text(e.name ?? '')))
                        .toList(),
                    decoration: const InputDecoration(labelText: 'Country'),
                    validator: FormBuilderValidators.required(),
                    onChanged: (value) => context
                        .read<AddressFormCubit>()
                        .loadRegions(isocode: value!),
                  ),

                  // title
                  // FormBuilderTextField(
                  //   name: 'title',
                  //   decoration: const InputDecoration(labelText: 'Title'),
                  // ),
                  // const SizedBox(height: FlexSizes.inputFieldSpacing),

                  // first name
                  FormBuilderTextField(
                    name: 'firstName',
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: FlexSizes.inputFieldSpacing),

                  // last name
                  FormBuilderTextField(
                    name: 'lastName',
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: FlexSizes.inputFieldSpacing),

                  // address line 1
                  FormBuilderTextField(
                    name: 'line1',
                    decoration:
                        const InputDecoration(labelText: 'Street Address'),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: FlexSizes.inputFieldSpacing),

                  // address line 2
                  FormBuilderTextField(
                    name: 'line2',
                    decoration: const InputDecoration(
                        labelText: 'Apt, Suite (optional)'),
                  ),
                  const SizedBox(height: FlexSizes.inputFieldSpacing),

                  // town
                  FormBuilderTextField(
                    name: 'town',
                    decoration: const InputDecoration(labelText: 'City'),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: FlexSizes.inputFieldSpacing),

                  // province/state and postal code
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown(
                          name: 'regionIsoCode',
                          items: state.regions
                              .map((e) => DropdownMenuItem(
                                  value: e.isocode, child: Text(e.name ?? '')))
                              .toList(),
                          decoration: const InputDecoration(
                              labelText: 'Province/State'),
                          validator: FormBuilderValidators.required(),
                        ),
                      ),
                      const SizedBox(width: FlexSizes.inputFieldSpacing),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'postalCode',
                          decoration: const InputDecoration(
                              labelText: 'Postal Code/Zip'),
                          validator: FormBuilderValidators.required(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: FlexSizes.inputFieldSpacing),

                  // phone number and mobile number
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'phone',
                          decoration: const InputDecoration(
                              labelText: 'Phone number (optional)'),
                        ),
                      ),
                      const SizedBox(width: FlexSizes.inputFieldSpacing),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'cellphone',
                          decoration: const InputDecoration(
                              labelText: 'Mobile number (optional)'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: FlexSizes.spacerSection),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        context
                            .read<AddressFormCubit>()
                            .saveAddress(_formKey.currentState!.value);
                      }
                    },
                    child: const Text('Add Address'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
