import 'package:dio/dio.dart';
import 'package:flex_storefront/account/models/title.dart';
import 'package:flex_storefront/account/models/user.dart';
import 'package:flex_storefront/auth/register/model/register_user_dto.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:flex_storefront/init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

const PATH = '/occ/v2/<CATALOG>/users';
const PARAMS = '?lang=en&curr=USD';

class UserApi {
  Future<User> fetchUser() async {
    final path = '$PATH/current'.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
          '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS',
        );

    return User.fromJson(response.data);
  }

  Future<void> updateUser(Map<String, dynamic> json) async {
    final path = '$PATH/current'.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    await GetIt.instance.get<Dio>(instanceName: Singletons.hybrisClient).patch(
          '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS',
          data: json,
        );
  }

  Future<User> registerUser(RegisterUserDto dto, {String? token}) async {
    final path = PATH.replaceAll(
      '<CATALOG>',
      GetIt.instance
          .get<ConfigRepository>()
          .getString(ConfigKey.shopHybrisCatalog),
    );

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .post(
          '${dotenv.get('HYBRIS_BASE_URL')}$path$PARAMS',
          data: dto.toJson(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
        );

    return User.fromJson(response.data);
  }

  Future<List<Title>> fetchTitles() async {
    final titlesPath = '/occ/v2/<CATALOG>/titles'.replaceAll(
        '<CATALOG>',
        GetIt.instance
            .get<ConfigRepository>()
            .getString(ConfigKey.shopHybrisCatalog));

    final response = await GetIt.instance
        .get<Dio>(instanceName: Singletons.hybrisClient)
        .get(
          '${dotenv.get('HYBRIS_BASE_URL')}$titlesPath$PARAMS',
        );

    return (response.data['titles'] as List<dynamic>)
        .map((e) => Title.fromJson(e))
        .toList();
  }
}
