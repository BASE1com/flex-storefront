import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/account/user_repository.dart';

abstract class UserSubscriptionCubit<T> extends Cubit<T> {
  late final StreamSubscription _userStreamSubscription;

  UserSubscriptionCubit(T initialState) : super(initialState) {
    _subscribe();
  }

  void _subscribe() {
    _userStreamSubscription = UserRepository.instance.userStream.listen(
      (user) {
        onUserData(user);
      },
      onError: (err, stackTrace) {
        onUserError(err, stackTrace);
      },
    );
  }

  void onUserData(User user);
  void onUserError(err, stackTrace);

  @override
  Future<void> close() async {
    await _userStreamSubscription.cancel();
    return super.close();
  }
}
