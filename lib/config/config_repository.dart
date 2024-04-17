import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flex_storefront/config/data/default_config.dart';
import 'package:loggy/loggy.dart';

mixin ConfigRepositoryLoggy implements LoggyType {
  @override
  Loggy<ConfigRepositoryLoggy> get loggy =>
      Loggy<ConfigRepositoryLoggy>('ConfigRepositoryLoggy');
}

class ConfigRepository with ConfigRepositoryLoggy {
  /// Initialize the RemoteConfig singleton, make the last fetched values
  /// or the local defaults (on first start) available.
  /// This method is fast since it doesn't fetch the config from the server.
  Future<void> init() async {
    loggy.info(
      'Initialization started, lastFetchStatus: ${FirebaseRemoteConfig.instance.lastFetchStatus}',
    );

    await FirebaseRemoteConfig.instance.setDefaults(defaultConfig);
    await FirebaseRemoteConfig.instance.activate();

    loggy.info(
      'Initialization ended, config activated',
    );
  }

  /// Fetch the latest config from the server and make it available to the
  /// getString, getBool, etc functions.
  /// No fetch operation is happening if the config has been fetched recently.
  Future<void> fetch() async {
    loggy.info('Fetch config from server...');

    await FirebaseRemoteConfig.instance.fetchAndActivate();

    loggy.info(
      'Fetch config from server: done.',
    );
  }

  String getString(String key) {
    return FirebaseRemoteConfig.instance.getString(key);
  }
}
