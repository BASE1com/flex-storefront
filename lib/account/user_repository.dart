import 'dart:async';

import 'package:flex_storefront/account/apis/user_api.dart';
import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/auth/auth_repository.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:rxdart/rxdart.dart';

mixin UserRepositoryLoggy implements LoggyType {
  @override
  Loggy<UserRepositoryLoggy> get loggy =>
      Loggy<UserRepositoryLoggy>('UserRepositoryLoggy');
}

class UserRepository with UserRepositoryLoggy {
  static UserRepository get instance => GetIt.instance<UserRepository>();

  UserRepository({required UserApi userApi}) : _userApi = userApi {
    init();
  }

  final UserApi _userApi;

  final _userStreamController = BehaviorSubject<User>.seeded(User.empty);

  // Provide a [Stream] of the near real-time cart
  Stream<User> get userStream => _userStreamController.asBroadcastStream();

  User get currentUser => _userStreamController.value;

  /// Initialize the UserRepository, fetch the user from the server.
  Future<void> init() async {
    loggy.info(
      'User initialization started...',
    );

    GetIt.instance.get<AuthRepository>().authStatus.listen((event) async {
      if (event == AuthenticationStatus.unauthenticated) {
        loggy.info('Anonymous user, emptying stream');
        _userStreamController.add(User.empty);
      } else if (event == AuthenticationStatus.authenticated) {
        loggy.info('User loading');
        await fetchUser();
      }
    });

    loggy.info(
      'Cart initialization ended, cart ready',
    );
  }

  Future<void> fetchUser() async {
    try {
      final user = await _userApi.fetchUser();
      _userStreamController.add(user);
    } on Exception catch (e) {
      _userStreamController.addError(e);
    }
  }

  Future<void> updateUser(Map<String, dynamic> userAttributes) async {
    try {
      await _userApi.updateUser(userAttributes);
      fetchUser();
    } on Exception catch (e) {
      _userStreamController.addError(e);
    }
  }

  Future<void> dispose() async {
    await _userStreamController.close();
  }
}
