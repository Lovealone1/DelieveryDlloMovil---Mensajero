import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delievery_domiciliario/constant/constant.dart';

class PushNotificationServices {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static Future initializeFirebaseMessaging() async {
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(firebaseMessagingForegroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  static Future<void> firebaseMessagingForegroundHandler(
      RemoteMessage message) async {}

  static Future getToken() async {
    String? token = await firebaseMessaging.getToken();
    log('Token: \n$token');
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child('Driver/${auth.currentUser!.uid}/cloudMessagingToken');
    databaseReference.set(token);
  }
  static subscribeToNotification(){
    firebaseMessaging.subscribeToTopic('COVEFOOD_PARTNER');
  }

  static initializeFCM(){
    initializeFirebaseMessaging();
    getToken();
    subscribeToNotification();
  }
}
