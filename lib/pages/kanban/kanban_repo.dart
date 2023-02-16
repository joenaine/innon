import 'package:innon/data/card/card.dart';
import 'package:innon/pages/create_board/create_board_repo.dart';

class KanbanRepo {
  Future<void> boardCardList(List<BoardCard> c, int id) async {
    try {
      // List<BoardCard> newList = List.from(c);
      // DocumentReference docRef =
      //     firestore.collection('boards').doc(id.toString());

      // DocumentSnapshot docSnapshot = await docRef.get();

      // if (docSnapshot.exists) {
      //   Map<String, dynamic> docData =
      //       docSnapshot.data() as Map<String, dynamic>;
      //   List<Map<String, dynamic>> tickets = (docData["cards"] as List)
      //       .map((element) => Map<String, dynamic>.from(element))
      //       .toList();
      //   print('ASSSSSSSS${tickets.length}');
      //   if (tickets.isNotEmpty) {
      //     newList = tickets.map((e) => BoardCard.fromJson(e)).toList() + c;
      //   }
      // }

      CreateBoardRepo().updateBoardCard(c, id);
    } catch (e) {}
  }
}
