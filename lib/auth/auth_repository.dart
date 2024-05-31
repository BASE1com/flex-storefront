import 'dart:async';

import 'package:flex_storefront/auth/apis/auth_api.dart';
import 'package:flex_storefront/init.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

mixin AuthRepositoryLoggy implements LoggyType {
  @override
  Loggy<AuthRepositoryLoggy> get loggy =>
      Loggy<AuthRepositoryLoggy>('AuthRepositoryLoggy');
}

class AuthRepository with AuthRepositoryLoggy {
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  final _authStreamController = BehaviorSubject<AuthenticationStatus>();

  final AuthApi _authApi;
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
      tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
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
    final token = await _authApi.getToken(email, password);
    await freshInstance.setToken(token);
    loggy.info('Login successful, set token: ${token.accessToken}');
  }

  /// [EmailAuthentication] - Register
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    loggy.info('Register..');
    // return _firebaseAuth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );
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
    await freshInstance.setToken(null);
  }

  Future<void> dispose() async {
    await freshSubscription.cancel();
    await freshInstance.close();
    await _authStreamController.close();
  }
}
