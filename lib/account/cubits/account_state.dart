import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class AccountState extends BlocState {
  final bool isLoggedIn;
  final User? user;

  AccountState({
    required super.status,
    this.isLoggedIn = false,
    this.user,
  });

  AccountState copyWith({
    Status? status,
    bool? isLoggedIn,
    User? user,
  }) =>
      AccountState(
        status: status ?? this.status,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        user: user ?? this.user,
      );
}
