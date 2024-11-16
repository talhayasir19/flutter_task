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
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "flutterapitask-ed2b1",
      "private_key_id": "9ccf06bae67e7acd26e3f7495935eb877ea3e2bd",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC3pjDps+6BXjDA\nHzsDpLYGuQSzhJOzkqBAmAsoOKBD2tt/rZvMKrGBzyHYsXP2VNBSk9S+7d0wrNRz\nIKzpnwE4S4H04s58SoluUNMg83zWnUMgapZClFRoqV6N1eJjUe5I/1fiHfnlVFhm\n+8awkpVm1pB6qQrfLP6i3uF9a7yI7zrtdTr+miGTCOrQLlDCCkT8umGADdLo3RmV\nXjkkhHVKva3TYFw1995Fjk/x+/m/ftTL4xanmWSZvWWAEgUA9tLFdNEXV+JnxqsK\nAAykg+TXCcEsSh6Ck8TUbPZweWwbg87Bh4d5DXjYm13D7qabDGyvAfv3TmE8BWPU\nWIF5W3GHAgMBAAECggEAC1hEYEOBwdMgPtYPDrgPmJW4YSCZAThXFvZthgQNfnOY\nKKiAXdnrUkIJ7Ll1mOt/XQKN22eVSOr8SspjdCEi8afUdNzH9ayjFcH/cOMpvJZF\nbcy30JAaMMb5tNhYHluS1UaU1r6UT+LofSAjk4fSm+I4VaN4rPW6GzSaiGVt5aWK\nrXNfSkIrqGj7dyO6SmfLNg5Py71XPZeglLOiacpnU7hnu1YhonFreDWqR1FgmgiZ\n3KjMPagthtlz8UcgT/BsfZIkBOaUMUn2YvwYJx2Ir6dBbp2YyfVsjsgoLVz9LzmS\nzF2hXTM7QB7T+AOdXrz5yzrWWH/5YMaZ4gdCH1DCwQKBgQDzjwLnWMmssXlbMrX8\nYhH3e4Od98KIjAXMji8NLEzEPEuPSkl+pYisbUgzdFq7J0YYZWjBO1fRS05XGphl\nNBtDsyk9BRytK2+HWHwTTp2RYjZ34TyRKTNpIkXh448xgN46WKNXEkwuOIjSvrIM\n+oyXEkbHaxw9L+kwoVXc6BNGQQKBgQDBB8Am1rI0aN8FgYI64il1kpHsiTPM8ZL3\nY65TnyInO0uMzJFhv6qLcC7v4Xci31ikzD3jkv3fX9MCdlqiW2b2DBcOtabLI3ra\n6kzbgf49oQdyyEje+tRDhxvb5GNBIp0a4RIdEA5gQqwBLo3s6hzXNjCwHaTSdeaZ\niL7pE3yVxwKBgCy0Oic2b8XnyUuI8khBw+R14kGTYTxo3wOdsVssn2aBXqkNTJIX\nVg+3+0GegKzLV51Qt7qH5uV+egGY2xHwT3TMpKwTjSDn0Q+5mQR+MIOn0DGOwOwv\n8MTCSqtcdkLy0VdKP6jSrfLp44sy/0FMl5N/AkjGCyfb7GRFqJnkau1BAoGAMAky\nuzeQb1Rts5wQAYFImfaYk8ls96JiVWgb+LlQMX0jBu3de/rLgRmwxIdSM35rO8+L\n0zdAMDdTdnhng6HFVJObpVB1KnYw24uVBscpssKA7QKEh+DZs9hKiYUjYhEwEYFT\nFaJqQXA2B7FDJmL4PGJC6YDnBGzMrwaFo9Dynv8CgYEAw3AqIQBcVLndAKDeqLNo\n33EEAz6PPMdDBjaRVTN/fIKW+7kkhTJDcFMpUH4B+BnxeTZOWeUsQ7T5XxInWuO7\nY7f+SMjvcifpH/8kpoMWcysL3NDlMF4bWTYPutrUqPQUQ/EcC0/6jlfrQtt3z1gG\nAxmaIGFagfKxKNV17gpbg/8=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "flutterapitask@flutterapitask-ed2b1.iam.gserviceaccount.com",
      "client_id": "108580916388657416846",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/flutterapitask%40flutterapitask-ed2b1.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

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
