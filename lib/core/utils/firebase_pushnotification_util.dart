import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

Future<void> backgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.messageId}');
}

class PushNotificationUtil {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permissions
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    log("Device Token: $token");
    String? accessToken = await getServerAccessToken();
    log("Access Token: $accessToken");
  }

  static Future<String> getServerAccessToken() async {
    final serviceAccountJson = {};

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Get Access Token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();

    return credentials.accessToken.data;
  }

  static Future<void> sendNotification({
    required String deviceToken,
    required String message,
  }) async {
    final String serverToken = await getServerAccessToken();

    // You will get Project Id from google-services.json
    String endpointFCM =
        "https://fcm.googleapis.com/v1/projects/flutterapitask-ed2b1/messages:send";
    final Map<String, dynamic> bodyMessage = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': 'App Name',
          'body': message,
        },
        // Data is optional if you want to add any payload into notification.
        'data': {}
      }
    };

    try {
      final http.Response response = await http.post(Uri.parse(endpointFCM),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $serverToken',
          },
          body: jsonEncode(bodyMessage));
      log(response.body);
      if (response.statusCode == 200) {
        log("Sent Notification successfully");
      } else {
        log("Failed Notification");
      }
    } catch (e) {
      log("Some error $e");
    }
  }
}
