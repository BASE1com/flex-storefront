import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/account/user_repository.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flex_storefront/shared/utils/user_subscription_cubit.dart';

part 'edit_account_state.dart';

class EditAccountCubit extends UserSubscriptionCubit<EditAccountState> {
  EditAccountCubit() : super(EditAccountState(status: Status.initial));

  @override
  void onUserData(User user) {
    emit(state.copyWith(
      status: Status.success,
      user: user,
    ));
  }

  @override
  void onUserError(err, stackTrace) {
    emit(state.copyWith(
      status: Status.failure,
      user: User.empty,
      error: err,
      stackTrace: stackTrace,
    ));
    addError(err, stackTrace);
  }

  Future<void> updateUser(Map<String, dynamic> userAttributes) async {
    emit(state.copyWith(
      status: Status.pending,
    ));

    await UserRepository.instance.updateUser(userAttributes);
  }
}
