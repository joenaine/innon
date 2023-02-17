import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innon/data/completed_task/completed_task.dart';
import 'package:innon/data/completed_tasks/completed_tasks.dart';
import 'package:innon/pages/board_list/board_list_page.dart';
import 'package:innon/pages/home/home_page.dart';

class TasksRepo {
  Future<void> setHistory(List<CompletedTask> completedTasks) async {
    try {
      DocumentReference docRef = firestore.collection('history').doc('0');

      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        firestore.collection('history').doc('0').update({
          'completedTasks': FieldValue.arrayUnion(
              completedTasks.map((e) => e.toJson()).toList()),
        });
      } else {
        firestore.collection('history').doc('0').set({
          'completedTasks': FieldValue.arrayUnion(
              completedTasks.map((e) => e.toJson()).toList()),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> setHistoryToUser(
      CompletedTask completedTask, String userID) async {
    try {
      DocumentReference docRef = firestore
          .collection('users')
          .doc(userID)
          .collection('history')
          .doc('0');

      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        firestore
            .collection('users')
            .doc(userID)
            .collection('history')
            .doc('0')
            .update({
          'completedTasks': FieldValue.arrayUnion([completedTask.toJson()]),
        });
      } else {
        firestore
            .collection('users')
            .doc(userID)
            .collection('history')
            .doc('0')
            .set({
          'completedTasks': FieldValue.arrayUnion([completedTask.toJson()]),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<CompletedTasks> getHistoryOfUser() async {
    CompletedTasks e = CompletedTasks();

    return firestore
        .collection('users')
        .doc(user?.uid)
        .collection('history')
        .doc('0')
        .get()
        .then((result) {
      e = CompletedTasks.fromFirestore(result);
      print('COMP${e.completedTasks?.length}');
      return e;
    });
  }

  Future<CompletedTasks> getHistory() async {
    CompletedTasks e = CompletedTasks();

    return firestore.collection('history').doc('0').get().then((result) {
      e = CompletedTasks.fromFirestore(result);
      print('COMP${e.completedTasks?.length}');
      return e;
    });
  }
}
