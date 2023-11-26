import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notification) async {
    });
  }


  static void display(dynamic message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;


      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "atcho", "atcho_channel",
              importance: Importance.max, priority: Priority.high));

      await _notificationsPlugin.show(id, message["text"]["info"]["title"],
        message["text"]["info"]["content"], notificationDetails,
        payload: "message.messageId",
      );
    } on Exception catch (e) {

    }
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');

    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android, );
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip, inputData);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip, inputData) async {

  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "atcho", "atcho_channel",
      importance: Importance.max, priority: Priority.high,
  );

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
  );
  await flip.show(0, inputData["text"]["info"]["title"],
      inputData["text"]["info"]["content"],
      platformChannelSpecifics, payload: 'Default_Sound'
  );
}
