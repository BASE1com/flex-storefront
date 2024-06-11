import 'package:dio/dio.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';

const PATH = '/authorizationserver/oauth/token';

class AuthApi {
  Future<OAuth2Token> getToken({String? username, String? password}) async {
    Map<String, dynamic> requestBody = {
      'grant_type': password != null ? 'password' : 'client_credentials',
      'client_id': dotenv.get('HYBRIS_CLIENT_ID'),
      'client_secret': dotenv.get('HYBRIS_CLIENT_SECRET'),
    };

    if (username != null && password != null) {
      requestBody['username'] = username;
      requestBody['password'] = password;
    }

    final response =
        await GetIt.instance<Dio>(instanceName: Singletons.hybrisClient).post(
      '${dotenv.get('HYBRIS_BASE_URL')}$PATH',
      data: requestBody,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    return OAuth2Token(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
      expiresIn: response.data['expires_in'],
    );
  }

  Future<OAuth2Token> refreshToken(OAuth2Token? token) async {
    if (token == null) {
      // Can happen if the user has wiped the data using the device settings
      // instead of the in-app "Clean application data" feature.
      throw Exception('refreshToken: OAuth2Token object is null');
    }

    final requestBody = {
      'grant_type': 'refresh_token',
      'client_id': dotenv.get('HYBRIS_CLIENT_ID'),
      'client_secret': dotenv.get('HYBRIS_CLIENT_SECRET'),
      'refresh_token': token.refreshToken,
    };

    final response =
        await GetIt.instance<Dio>(instanceName: Singletons.hybrisClient).post(
      '${dotenv.get('HYBRIS_BASE_URL')}$PATH',
      data: requestBody,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    return OAuth2Token(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
      expiresIn: response.data['expires_in'],
    );
  }
}
