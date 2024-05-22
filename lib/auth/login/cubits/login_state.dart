import 'package:flex_storefront/shared/bloc_helper.dart';

class LoginState extends BlocState {
  LoginState({
    required super.status,
    super.error,
    super.stackTrace,
    this.rememberMe = false,
    this.hidePassword = true,
    this.email = '',
  });

  final bool rememberMe;
  final bool hidePassword;
  final String email;

  copyWith({
    Status? status,
    Object? error,
    StackTrace? stackTrace,
    bool? rememberMe,
    bool? hidePassword,
    String? email,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      rememberMe: rememberMe ?? this.rememberMe,
      hidePassword: hidePassword ?? this.hidePassword,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'LoginState{status: $status, rememberMe: $rememberMe, '
        'hidePassword: $hidePassword, email: $email}';
  }
}
