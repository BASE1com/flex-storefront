import 'dart:convert';

import 'package:flex_storefront/auth/utils/serializable_oauth2_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';

/// Fresh token storage that uses Keychain on iOS and Keystore on Android
class SecureOAuth2TokenStorage extends TokenStorage<OAuth2Token> {
  final String storageKey;
  final _storage = GetIt.instance.get<FlutterSecureStorage>();
  OAuth2Token? _token;

  SecureOAuth2TokenStorage({
    required this.storageKey,
  });

  @override
  Future<void> delete() async {
    _token = null;

    await _storage.delete(key: storageKey);
  }

  @override
  Future<OAuth2Token?> read() async {
    final token = await _storage.read(key: storageKey);
    if (token != null) {
      _token = buildOAuth2TokenFromJson(jsonDecode(token));
    }

    return _token;
  }

  @override
  Future<void> write(OAuth2Token token) async {
    await _storage.write(
      key: storageKey,
      value: jsonEncode(token.toJson()),
    );

    _token = token;
  }
}
