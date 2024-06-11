import 'package:flex_storefront/account/models/title.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class RegisterState extends BlocState {
  RegisterState({
    required super.status,
    super.error,
    super.stackTrace,
    this.titles = const [],
    this.hidePassword = true,
  });

  final List<Title> titles;
  final bool hidePassword;

  copyWith({
    Status? status,
    Object? error,
    StackTrace? stackTrace,
    List<Title>? titles,
    bool? hidePassword,
  }) {
    return RegisterState(
      status: status ?? this.status,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      titles: titles ?? this.titles,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }

  @override
  String toString() {
    return 'RegisterState{status: $status, titles: $titles, '
        'hidePassword: $hidePassword}';
  }
}
