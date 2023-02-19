import 'dart:convert';

import 'package:http/http.dart';
import 'package:innon/pages/board_list/board_list_page.dart';
import 'package:innon/pages/home/home_page.dart';

class SendToken {
  static void saveToken(token) async {
    firestore.collection('users').doc(user?.uid).update({
      'token': token,
    });
  }

  static Future<String> getUserToken(id) async {
    return firestore.collection('UserTokens').doc(id).get().then((result) {
      print('TOKEN FROM FIRE${result.data()?['token']}');
      return result.data()?['token'];
    });
  }

  static void sendPushMessage(String body, String title, String token) async {
    try {
      await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAArAA_fq4:APA91bHooWgJZ7sSLvPfWOCVS9k_RFkcHydvFhGW0SOxAF2ZaVkWMQ1RzCUDfMNmP51D7PhPhVKas9vpWlooQURT7OcAx8lEgXhf7dAjHfIsHnnw4758qwqzxJc6zQ2Yd3ZbEfYuwISH',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }
}
