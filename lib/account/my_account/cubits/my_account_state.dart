import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';

class MyAccountState extends BlocState {
  final bool isLoggedIn;
  final User user;

  MyAccountState({
    required super.status,
    this.isLoggedIn = false,
    required this.user,
  });

  MyAccountState copyWith({
    Status? status,
    bool? isLoggedIn,
    User? user,
  }) =>
      MyAccountState(
        status: status ?? this.status,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        user: user ?? this.user,
      );
}
