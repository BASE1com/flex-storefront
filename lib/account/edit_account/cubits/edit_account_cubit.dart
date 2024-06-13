import 'dart:async';

import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/account/user_repository.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_account_state.dart';

class EditAccountCubit extends Cubit<EditAccountState> {
  late final StreamSubscription _userStreamSubscription;

  EditAccountCubit() : super(EditAccountState(status: Status.initial)) {
    _userStreamSubscription = UserRepository.instance.userStream.listen((user) {
      emit(state.copyWith(
        status: Status.success,
        user: user,
      ));
    });
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }
}
