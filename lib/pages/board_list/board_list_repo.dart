import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innon/data/board/board.dart';
import 'package:innon/pages/board_list/board_list_page.dart';

class BoardListRepo {
  Future<List<Board>> boardList() async {
    List<Board> events = [];

    return firestore.collection("boards").get().then((result) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> category
          in result.docs) {
        events.add(Board.fromFirestore(category));
      }
      return events;
    });
  }
}
