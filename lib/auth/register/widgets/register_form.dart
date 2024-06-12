import 'package:flex_storefront/auth/register/cubits/register_cubit.dart';
import 'package:flex_storefront/auth/register/cubits/register_state.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:icons_plus/icons_plus.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final _formKey = GlobalKey<FormBuilderState>(debugLabel: 'login_form');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FlexSizes.spacerItems,
            ),
            child: Column(
              children: [
                // title
                FormBuilderDropdown(
                  name: 'titleCode',
                  items: state.titles
                      .map((e) =>
                          DropdownMenuItem(value: e.code, child: Text(e.name)))
                      .toList(),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(LineAwesome.tag_solid),
                      labelText: 'Title'),
                ),
                const SizedBox(height: FlexSizes.inputFieldSpacing),

                // first and last name
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'firstName',
                        decoration: const InputDecoration(
                          prefixIcon: Icon(LineAwesome.user),
                          labelText: 'First name',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                    const SizedBox(width: FlexSizes.inputFieldSpacing),
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'lastName',
                        decoration: const InputDecoration(
                          labelText: 'Last name',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: FlexSizes.inputFieldSpacing),

                // email
                FormBuilderTextField(
                  name: 'uid',
                  decoration: const InputDecoration(
                    prefixIcon: Icon(LineAwesome.mail_bulk_solid),
                    labelText: 'Email',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: FlexSizes.inputFieldSpacing),

                // password
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return FormBuilderTextField(
                      name: 'password',
                      obscureText: state.hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesome.lock_solid),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () => context
                              .read<RegisterCubit>()
                              .togglePasswordVisibility(),
                          icon: Icon(
                            state.hidePassword
                                ? LineAwesome.eye_slash_solid
                                : LineAwesome.eye_solid,
                          ),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6,
                            errorText:
                                'Password must be at least 6 characters long.'),
                        FormBuilderValidators.match('[A-Z]',
                            errorText:
                                'Password must contain at least one uppercase letter.'),
                        FormBuilderValidators.match('[0-9]',
                            errorText:
                                'Password must contain at least one number.'),
                        FormBuilderValidators.match('[!@#\$%^&*(),.?":{}|<>]',
                            errorText:
                                'Password must contain at least one special character.'),
                      ]),
                    );
                  },
                ),
                const SizedBox(height: FlexSizes.spacerItems),

                // confirm password
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return FormBuilderTextField(
                      name: 'confirmPassword',
                      obscureText: state.hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesome.lock_solid),
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: () => context
                              .read<RegisterCubit>()
                              .togglePasswordVisibility(),
                          icon: Icon(
                            state.hidePassword
                                ? LineAwesome.eye_slash_solid
                                : LineAwesome.eye_solid,
                          ),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6,
                            errorText:
                                'Password must be at least 6 characters long.'),
                        FormBuilderValidators.match('[A-Z]',
                            errorText:
                                'Password must contain at least one uppercase letter.'),
                        FormBuilderValidators.match('[0-9]',
                            errorText:
                                'Password must contain at least one number.'),
                        FormBuilderValidators.match('[!@#\$%^&*(),.?":{}|<>]',
                            errorText:
                                'Password must contain at least one special character.'),
                        (value) {
                          if (value !=
                              _formKey.currentState!.value['password']) {
                            return 'Passwords do not match';
                          }
                          return null;
                        }
                      ]),
                    );
                  },
                ),
                const SizedBox(height: FlexSizes.spacerItems),

                // terms & conditions
                FormBuilderCheckbox(
                  name: 'terms',
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'I am confirming that I agree to the ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                  initialValue: false,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.equal(
                      true,
                      errorText: 'You must accept the terms to continue.',
                    ),
                  ]),
                ),

                // sign up button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        context.read<RegisterCubit>().emailAndPasswordRegister(
                            _formKey.currentState!.value);
                      }
                    },
                    child: const Text('Create account'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
