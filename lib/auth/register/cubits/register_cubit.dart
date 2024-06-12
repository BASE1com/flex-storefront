import 'package:bloc/bloc.dart';
import 'package:flex_storefront/account/apis/user_api.dart';
import 'package:flex_storefront/auth/auth_repository.dart';
import 'package:flex_storefront/auth/register/cubits/register_state.dart';
import 'package:flex_storefront/auth/register/model/register_user_dto.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:get_it/get_it.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
      : super(RegisterState(
          status: Status.initial,
        )) {
    init();
  }

  Future<void> init() async {
    try {
      final titles = await GetIt.instance.get<UserApi>().fetchTitles();

      emit(state.copyWith(
        titles: titles,
      ));
    } catch (e, stacktrace) {
      emit(state.copyWith(
        status: Status.failure,
        error: e,
        stackTrace: stacktrace,
      ));
    }
  }

  Future<void> emailAndPasswordRegister(
    Map<String, dynamic> form,
  ) async {
    try {
      emit(state.copyWith(status: Status.pending));

      await GetIt.instance.get<AuthRepository>().registerWithEmailAndPassword(
            userDto: RegisterUserDto(
              uid: form['uid'],
              password: form['password'],
              firstName: form['firstName'],
              lastName: form['lastName'],
              titleCode: form['titleCode'],
            ),
          );

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

  void togglePasswordVisibility() {
    emit(state.copyWith(
        status: Status.initial, hidePassword: !state.hidePassword));
  }
}
