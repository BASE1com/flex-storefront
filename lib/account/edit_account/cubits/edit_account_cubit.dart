import 'dart:async';

import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_account_state.dart';

class EditAccountCubit extends Cubit<EditAccountState> {
  // late final StreamSubscription _subscription;

  EditAccountCubit() : super(EditAccountState(status: Status.initial));

  // void _subscribe() async {
  //   _subscription = UserRepository.instance.userStream.listen((user) {
  //     emit(state.copyWith(
  //       status: Status.initial,
  //       user: user,
  //     ));
  //   });
  // }

  @override
  Future<void> close() {
    // _subscription.cancel();
    return super.close();
  }
}
