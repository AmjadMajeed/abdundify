import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApiClass {
  static final _pushNotifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetailMethod() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
        ),
        iOS: IOSNotificationDetails());
  }

  static void showScheduledNotificationMethod({
    required int id,
    required String titleText,
    required String notificationBody,
    required String payloadd,
    required DateTime scheduledDateTime,
  }) async =>
      _pushNotifications.zonedSchedule(
        id,
        titleText,
        notificationBody,
        tz.TZDateTime.from(scheduledDateTime, tz.local),
        await _notificationDetailMethod(),
        payload: payloadd,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
}

///it was showing error thats why i created it, have to remove it
IOSNotificationDetails() {
}
