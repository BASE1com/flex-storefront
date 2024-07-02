import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';
import 'package:permission_handler/permission_handler.dart';

mixin NotificationRepositoryLoggy implements LoggyType {
  @override
  Loggy<NotificationRepositoryLoggy> get loggy =>
      Loggy<NotificationRepositoryLoggy>('NotificationRepositoryLoggy');
}

class NotificationRepository with NotificationRepositoryLoggy {
  static NotificationRepository get instance =>
      GetIt.instance<NotificationRepository>();

  NotificationRepository() {
    init();
  }

  Future<bool> get isEnabled => Permission.notification.isGranted;

  Future<void> init() async {
    loggy.info(
      'Notifications initialization started...',
    );

    await Emarsys.setup(
        EmarsysConfig(applicationCode: dotenv.get('EMARSYS_APP_CODE')));

    // Initialize Emarsys
    Emarsys.push.registerAndroidNotificationChannels([
      NotificationChannel(
        id: 'marketing',
        name: 'Marketing',
        description: 'Marketing notification channel',
        importance: NotificationChannel.IMPORTANCE_HIGH,
      ),
    ]);

    loggy.info(
      'Notifications initialization ended, ready to receive notifications',
    );
  }

  Future<void> requestPermissions() async {
    final status = await Permission.notification.status;
    loggy.info('Current status: $status');

    if (await Permission.notification.request().isGranted) {
      loggy.info('Notification permissions granted');
    } else {
      loggy.warning('Notification permissions denied');
    }

    if (await Permission.notification.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enables it in the system settings.
      openAppSettings();
    }
  }

  Future<void> disableNotifications() async {
    await openAppSettings();
    loggy.info('Notifications disabled');
  }

  Future<void> printDebugInfo() async {
    final status = await Permission.notification.status;

    loggy.info('-- Notification Permissions --');
    loggy.info('Status: $status');

    String hardwareId = await Emarsys.config.hardwareId();
    String? appCode = await Emarsys.config.applicationCode();
    String? merchantId = await Emarsys.config.merchantId();
    int? contactFieldId = await Emarsys.config.contactFieldId();
    NotificationSettings settings = await Emarsys.config.notificationSettings();

    loggy.info('-- Emarsys Debug --');
    loggy.info('Hardware ID: $hardwareId');
    loggy.info('App Code: $appCode');
    loggy.info('Merchant ID: $merchantId');
    loggy.info('Contact Field ID: $contactFieldId');
    loggy.info('Notification Settings: $settings');
  }
}
