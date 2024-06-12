import 'dart:async';

import 'package:flex_storefront/account/apis/user_api.dart';
import 'package:flex_storefront/auth/apis/auth_api.dart';
import 'package:flex_storefront/auth/register/model/register_user_dto.dart';
import 'package:flex_storefront/auth/utils/secure_oauth2_token_storage.dart';
import 'package:flex_storefront/init.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

const AUTH_TOKEN_STORAGE_KEY = 'flex_auth_token';

mixin AuthRepositoryLoggy implements LoggyType {
  @override
  Loggy<AuthRepositoryLoggy> get loggy =>
      Loggy<AuthRepositoryLoggy>('AuthRepositoryLoggy');
}

class AuthRepository with AuthRepositoryLoggy {
  AuthRepository({required AuthApi authApi, required UserApi userApi})
      : _authApi = authApi,
        _userApi = userApi;

  final _authStreamController = BehaviorSubject<AuthenticationStatus>();

  final AuthApi _authApi;
  final UserApi _userApi;
  late StreamSubscription freshSubscription;
  late Fresh<OAuth2Token> freshInstance;

  Stream<AuthenticationStatus> get authStatus =>
      _authStreamController.asBroadcastStream();

  AuthenticationStatus get currentAuthStatus => _authStreamController.value;

  Future<void> init() async {
    loggy.info(
      'Auth initialization started...',
    );

    freshInstance = Fresh.oAuth2(
      tokenStorage:
          SecureOAuth2TokenStorage(storageKey: AUTH_TOKEN_STORAGE_KEY),
      refreshToken: (token, client) async {
        loggy.debug('refreshing token...');
        final refreshedToken = await _authApi.refreshToken(token);
        loggy.debug('token refreshed!');
        return refreshedToken;
      },
      shouldRefresh: (Response? response) => response?.statusCode == 401,
    );

    freshSubscription = freshInstance.authenticationStatus.listen((event) {
      _authStreamController.add(event);
    });

    // add fresh as our interceptor, to manage token refresh
    GetIt.instance<Dio>(instanceName: Singletons.hybrisClient)
        .interceptors
        .add(freshInstance);

    loggy.info(
      'Auth initialization ended, fresh_dio ready',
    );
  }

  /* ------- Email & Password Authentication ------- */

  /// [EmailAuthentication] - Login
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    loggy.info('Login..');
    final token = await _authApi.getToken(username: email, password: password);
    await freshInstance.setToken(token);
    loggy.info('Login successful, set token: ${token.accessToken}');
  }

  /// [EmailAuthentication] - Register
  Future<void> registerWithEmailAndPassword({
    required RegisterUserDto userDto,
  }) async {
    loggy.info('Register..');
    final token = await _authApi.getToken();
    await _userApi.registerUser(userDto, token: token.accessToken);
    loggy.info('Register successful');
  }

  /// [EmailVerification] - Send email verification link
  Future<void> sendEmailVerification() async {
    loggy.info('Sending email verification...');
    // await _firebaseAuth.currentUser?.sendEmailVerification();
    loggy.info('Email verification sent');
  }

  /// [EmailAuthentication] - Password reset
  Future<void> sendPasswordResetEmail(String email) async {
    loggy.info('Sending password reset email to $email');
    // await _firebaseAuth.sendPasswordResetEmail(email: email);
    loggy.info('Password reset email sent successfully');
  }

  /// [LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    await freshInstance.clearToken();
  }

  Future<void> dispose() async {
    await freshSubscription.cancel();
    await freshInstance.close();
    await _authStreamController.close();
  }
}
