import 'package:flutter/material.dart';
import 'package:innon/data/board/board.dart';
import 'package:innon/pages/board_list/board_list_repo.dart';
import 'package:innon/pages/create_board/create_board_repo.dart';

class BoardListProvider extends ChangeNotifier {
  final BoardListRepo _event = BoardListRepo();

  List<Board> orgEvents = [];
  // List<Board> get orgEvents => _orgEvents;

  loadOrgEvents() async {
    orgEvents = await _event.boardList();
    notifyListeners();
  }

  int selectedBackgroundIndex = 0;

  void selectBackground(int newBackgroundIndex) {
    selectedBackgroundIndex = newBackgroundIndex;
    notifyListeners();
  }

  void addBoard(Board board) {
    orgEvents.add(board);
    CreateBoardRepo().createBoard(board, board.index);
  }
}
