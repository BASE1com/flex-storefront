import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/auth/register/cubits/register_cubit.dart';
import 'package:flex_storefront/auth/register/cubits/register_state.dart';
import 'package:flex_storefront/auth/register/widgets/register_form.dart';
import 'package:flex_storefront/auth/register/widgets/register_header.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/colors.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const Scaffold(
        appBar: FlexAppBar(
          showBackArrow: true,
          leadingIcon: Icons.close,
          showSearchButton: false,
        ),
        body: RegisterView(),
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: FlexColors.success,
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 1500),
              elevation: FlexSizes.cardElevation,
              content: Text(
                'Account created successfully. Please login.',
                style: TextStyle(color: FlexColors.onSuccess),
              ),
            ),
          );
          context.router.maybePop();
        }
        if (state.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: FlexColors.error,
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 1500),
              elevation: FlexSizes.cardElevation,
              content: Text(
                'Account creation failed. Please try again later.',
                style: TextStyle(color: FlexColors.onError),
              ),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FlexSizes.appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RegisterHeader(),
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
