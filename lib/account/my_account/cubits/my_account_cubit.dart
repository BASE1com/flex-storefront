import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/account/apis/user_api.dart';
import 'package:flex_storefront/account/my_account/cubits/my_account_state.dart';
import 'package:flex_storefront/auth/auth_repository.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  late StreamSubscription _authStreamSubscription;

  MyAccountCubit()
      : super(
          MyAccountState(status: Status.initial),
        ) {
    _authStreamSubscription =
        GetIt.instance.get<AuthRepository>().authStatus.listen((status) {
      if (status == AuthenticationStatus.authenticated) {
        loadUser();
      }

      emit(state.copyWith(
        status: Status.success,
        isLoggedIn: status == AuthenticationStatus.authenticated,
      ));
    });
  }

  Future<void> loadUser() async {
    emit(state.copyWith(status: Status.pending));
    final user = await GetIt.instance.get<UserApi>().fetchUser();
    emit(state.copyWith(user: user, status: Status.success));
  }

  Future<void> logout() async {
    emit(state.copyWith(status: Status.pending));
    await GetIt.instance.get<AuthRepository>().logout();
    emit(MyAccountState(
      status: Status.success,
      isLoggedIn: false,
      user: null,
    ));
  }

  @override
  Future<void> close() async {
    await _authStreamSubscription.cancel();
    super.close();
  }
}
