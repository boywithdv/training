import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationProvider = Provider<NotificationViewModel>((ref) {
  return NotificationViewModel(ref.read);
});

class NotificationViewModel {
  final read;

  NotificationViewModel(this.read);

  Future<void> showNotification() async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    var localNotification = FlutterLocalNotificationsPlugin()
      ..initialize(initializationSettings);

    var androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
    );
    var iOSDetails = DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await localNotification.show(
        0, 'fitness END', '筋トレ終了', generalNotificationDetails);
  }
}
