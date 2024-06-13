import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flex_storefront/account/apis/user_api.dart';
import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/account/my_account/cubits/my_account_state.dart';
import 'package:flex_storefront/account/user_repository.dart';
import 'package:flex_storefront/auth/auth_repository.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  late final StreamSubscription _userStreamSubscription;

  MyAccountCubit() : super(MyAccountState(status: Status.initial)) {
    _userStreamSubscription = UserRepository.instance.userStream.listen((user) {
      emit(state.copyWith(
        status: Status.success,
        isLoggedIn: user != User.empty,
        user: user,
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
  }

  @override
  Future<void> close() async {
    await _userStreamSubscription.cancel();
    super.close();
  }
}
