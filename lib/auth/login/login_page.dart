import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/auth/login/cubits/login_cubit.dart';
import 'package:flex_storefront/auth/login/cubits/login_state.dart';
import 'package:flex_storefront/auth/login/widgets/login_form.dart';
import 'package:flex_storefront/auth/login/widgets/login_header.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/router.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const Scaffold(
        appBar: FlexAppBar(
          showBackArrow: true,
          leadingIcon: Icons.close,
          showSearchButton: false,
        ),
        body: LoginView(),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          context.router.replace(const HomeRoute());
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FlexSizes.appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LoginHeader(),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}