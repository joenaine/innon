import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/board/board.dart';
import '../../data/card/card.dart';
import '../../services/Generators/uui_generator.dart';

class CreateBoardRepo {
  final firestoreInstance = FirebaseFirestore.instance;
  String docID = UUIDGenerator().uuidV4();
  Future<void> createBoard(Board b, int index) async {
    try {
      firestoreInstance
          .collection('boards')
          .doc(index.toString())
          .set(b.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateBoard(Board b, int index) async {
    try {
      firestoreInstance
          .collection('boards')
          .doc(index.toString())
          .update(b.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateBoardCard(List<BoardCard> b, int index) async {
    try {
      firestoreInstance.collection('boards').doc(index.toString()).update({
        'cards': b.map((e) {
          return {
            'tasks': e.tasks.map((e) => e.toJson()).toList(),
            'title': e.title,
          };
        }).toList()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Board>> createBoardGet() async {
    List<Board> events = [];
    try {
      firestoreInstance.collection('boards').get().then((result) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> category
            in result.docs) {
          events.add(Board.fromFirestore(category));
        }
      });
      return events;
    } catch (e) {
      print(e);
      return events;
    }
  }

  Future<void> createBoardCard(
    List<BoardCard> b,
    int index,
  ) async {
    try {
      firestoreInstance.collection('boards').doc(index.toString()).update(
          {'cards': FieldValue.arrayUnion(b.map((e) => e.toJson()).toList())});
    } catch (e) {
      print(e);
    }
  }
}
