import 'package:fresh_dio/fresh_dio.dart';

/// Add serialization capabilities to [OAuth2Token].
///
/// Unfortunately we can't define the fromJson here. A Dart extension can't add
/// static methods on a class.
/// Maybe in the future: https://github.com/dart-lang/language/issues/723
extension OAuth2TokenExtension on OAuth2Token {
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
    };
  }
}

/// Utility method to deserialize a [OAuth2Token]
OAuth2Token buildOAuth2TokenFromJson(Map<String, dynamic> json) {
  return OAuth2Token(
    accessToken: json['access_token'],
    refreshToken: json['refresh_token'],
    expiresIn: json['expires_in'],
  );
}
