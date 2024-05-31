import 'package:bloc/bloc.dart';
import 'package:flex_storefront/auth/auth_repository.dart';
import 'package:flex_storefront/auth/login/cubits/login_state.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

const REMEMBER_EMAIL_KEY = 'remember_me_email';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(LoginState(
          status: Status.initial,
        )) {
    init();
  }

  void init() async {
    final email =
        GetIt.instance<SharedPreferences>().getString(REMEMBER_EMAIL_KEY);
    emit(state.copyWith(
      email: email,
      rememberMe: email != null,
    ));
  }

  Future<void> emailAndPasswordSignIn({
    required String email,
    required String password,
  }) async {
    try {
      // start loading
      emit(state.copyWith(
        status: Status.pending,
        email: email.trim(),
      ));

      // save data if remember me is checked
      if (state.rememberMe) {
        GetIt.instance<SharedPreferences>()
            .setString(REMEMBER_EMAIL_KEY, email.trim());
      } else {
        GetIt.instance<SharedPreferences>().remove(REMEMBER_EMAIL_KEY);
      }

      // register user in firebase
      await GetIt.instance.get<AuthRepository>().loginWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      // show success
      emit(state.copyWith(status: Status.success));
    } catch (e, stacktrace) {
      // show an error to the user
      emit(state.copyWith(
        status: Status.failure,
        error: e,
        stackTrace: stacktrace,
      ));
    }
  }

  void toggleRememberMe() {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }
}
