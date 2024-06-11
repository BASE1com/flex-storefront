import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/auth/login/cubits/login_cubit.dart';
import 'package:flex_storefront/auth/login/cubits/login_state.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormBuilderState>(debugLabel: 'login_form');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.email.isNotEmpty) {
          _formKey.currentState?.fields['email']?.didChange(state.email);
        }

        return FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FlexSizes.spacerItems,
            ),
            child: Column(
              children: [
                // Email field
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    prefixIcon: Icon(LineAwesome.envelope_solid),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  initialValue: state.email,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: FlexSizes.inputFieldSpacing),

                // Password field

                FormBuilderTextField(
                  name: 'password',
                  obscureText: state.hidePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(LineAwesome.lock_solid),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          context.read<LoginCubit>().togglePasswordVisibility(),
                      icon: Icon(
                        state.hidePassword
                            ? LineAwesome.eye_slash
                            : LineAwesome.eye,
                      ),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: FlexSizes.inputFieldSpacing),

                // Remember me and forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Remember me
                    Row(
                      children: [
                        Checkbox(
                          value: state.rememberMe,
                          onChanged: (_) =>
                              context.read<LoginCubit>().toggleRememberMe(),
                        ),
                        const Text('Remember me'),
                      ],
                    ),

                    // Forgot password
                    TextButton(
                      onPressed: () =>
                          context.router.navigateNamed('/forgot-password'),
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),
                const SizedBox(height: FlexSizes.spacerSection),

                // Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        context.read<LoginCubit>().emailAndPasswordSignIn(
                              email: _formKey.currentState!.value['email'],
                              password:
                                  _formKey.currentState!.value['password'],
                            );
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: FlexSizes.spacerItems),

                // Create account button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      context.router.replaceNamed('/register');
                    },
                    child: const Text('Register'),
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
