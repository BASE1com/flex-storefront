import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';

mixin AuthRepositoryLoggy implements LoggyType {
  @override
  Loggy<AuthRepositoryLoggy> get loggy =>
      Loggy<AuthRepositoryLoggy>('AuthRepositoryLoggy');
}

class AuthRepository with AuthRepositoryLoggy {
  static AuthRepository get instance => GetIt.instance<AuthRepository>();

  // bool get isLoggedIn => currentUser != null;
  // bool get isEmailVerified => currentUser?.emailVerified ?? false;

  Future<void> init() async {
    loggy.info(
      'Auth initialization started...',
    );

    loggy.info(
      'Initialization ended, auth fetched',
    );
  }

  /* ------- Email & Password Authentication ------- */

  /// [EmailAuthentication] - Login
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    loggy.info('Login..');
    // return _firebaseAuth.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );
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
    // TODO: Sign out of auth
  }
}
