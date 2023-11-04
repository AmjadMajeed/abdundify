import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:async'; // Import the 'dart:async' library

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Timer? _timer; // Add a Timer variable

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  // Modify the method to schedule repeated notifications every 1 minute
  void scheduleRepeatedNotifications(int numberOfNotifications) {
    print("scheduleRepeatedNotifications runss");
    try{
      int totalMinsPerDay = 1440;
      int min = (totalMinsPerDay / numberOfNotifications).toInt(); // Convert to int
      print("notification set for $min mins");
      _timer = Timer.periodic(Duration(minutes: min), (Timer timer) {
        scheduleNotification(
          title: "Hi!",
          body: 'Take Out Some Time To Manifest More Abundance',
          scheduledNotificationDateTime: DateTime.now().add(Duration(minutes: min)),
        );
        print("affairmation set successfull------------------");
      });
    }catch(e){
      print("error in scheduleRepeatedNotifications method");
    }
  }

  // Modify the method to schedule repeated notifications every 1 minute
  void scheduleRepeatedNotificationsForBlessing(int numberOfNotifications) {
    print("scheduleRepeatedNotifications runss");
    try{
      int totalMinsPerDay = 1440;
      int min = (totalMinsPerDay / numberOfNotifications).toInt(); // Convert to int
      print("notification set for $min mins");
      _timer = Timer.periodic(Duration(minutes: min), (Timer timer) {
        scheduleNotification(
          title: "Hi!",
          body: 'I am blessed',
          scheduledNotificationDateTime: DateTime.now().add(Duration(minutes: min)),
        );
        print("affairmation set successfull------------------");
      });
    }catch(e){
      print("error in scheduleRepeatedNotifications method");
    }
  }


  // Modify the method to schedule repeated notifications every 1 minute
  void scheduleRepeatedNotificationsForBank(int hours,int balance) {
    print("scheduleRepeatedNotificationsForBank runss");
   try{
     _timer = Timer.periodic(Duration(minutes: hours), (Timer timer) {
       scheduleNotification(
         title: "You Receive a New Payment",
         body: '\$ $balance Congrats',
         scheduledNotificationDateTime: DateTime.now().add(Duration(hours: hours)),
       );
       print("affairmation set successfull for bank+++++++++++++++++++++++");
     });
   }catch(e){
     print("error in scheduleRepeatedNotificationsForBank");
   }
  }

  // Cancel the repeating notifications when no longer needed
  void cancelRepeatedNotifications() {
    _timer?.cancel();
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
        String? title,
        String? body,
        String? payLoad,
        required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
}
