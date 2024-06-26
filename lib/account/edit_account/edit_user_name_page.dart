import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class EditUserNamePage extends StatelessWidget {
  const EditUserNamePage({
    super.key,
    required this.user,
    required this.onSave,
  });

  final User user;
  final void Function(Map<String, dynamic>) onSave;

  @override
  Widget build(BuildContext context) {
    final _formKey =
        GlobalKey<FormBuilderState>(debugLabel: 'change_user_name_form');

    return Scaffold(
      appBar: const FlexAppBar(
        title: Text('Change Name'),
        showBackArrow: true,
        showSearchButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(FlexSizes.appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text(
              'Update your personal details',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: FlexSizes.spacerSection),

            // form
            FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormBuilderTextField(
                      name: 'firstName',
                      initialValue: user.firstName,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: FlexSizes.inputFieldSpacing),
                    FormBuilderTextField(
                      name: 'lastName',
                      initialValue: user.lastName,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: FlexSizes.spacerSection * 1.5),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          onSave(_formKey.currentState!.value);
                          context.router.maybePop();
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
