import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innon/pages/board_list/board_list_provider.dart';
import 'package:innon/pages/create_board/create_board_repo.dart';

class TaskInfoProvider extends ChangeNotifier {
  BoardListProvider? storage;
  Timer? _timer;
  void update(BoardListProvider data) {
    storage = data;
  }

  bool canUpdateTask = true;

  bool isTimerRunning = false;

  int _countdown = 0;

  int get countdown => _countdown;

  void _onTick(Timer timer) {
    _countdown++;
    notifyListeners();
  }

  void startTimer() {
    isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    notifyListeners();
  }

  void stopTimer() {
    isTimerRunning = false;
    _timer!.cancel();
    notifyListeners();
  }

  void loadTask(int boardId, int cardId, int taskId) {
    final task = storage?.orgEvents[boardId].cards[cardId].tasks[taskId];
    if (task!.isTimerRunning) {
      final DateTime lastEntry = task.dateTimeEntry!;
      final int diff = (DateTime.now().difference(lastEntry)).inSeconds;
      _countdown = diff + task.countDown;
      startTimer();
    } else {
      _countdown = task.countDown;
    }
  }

  void updateTask(
    int boardId,
    int cardId,
    int taskId,
    String title,
    String description,
  ) {
    final task = storage!.orgEvents[boardId].cards[cardId].tasks[taskId];
    task.isTimerRunning = isTimerRunning;
    task.dateTimeEntry = DateTime.now();
    task.countDown = _countdown;
    task.description = description;
    task.title = title;

    CreateBoardRepo().updateBoard(storage!.orgEvents[boardId], boardId);
  }

  // void closeTask(
  //   int boardId,
  //   int cardId,
  //   int taskId,
  // ) {
  //   final tasks = storage!.orgEvents[boardId].cards[cardId].tasks;
  //   final completedTask = CompletedTask(
  //     title: tasks[taskId].title,
  //     completionDate: DateTime.now(),
  //     timeSpent: formattedTime(_countdown),
  //   );
  //   tasks.removeAt(taskId);

  //   notifyListeners();

  //   storage!.completedTasks.add(completedTask);
  //   TasksRepo().setHistory(storage!.completedTasks);
  // }

  // void deleteTask(
  //   int boardId,
  //   int cardId,
  //   int taskId,
  // ) {
  //   storage!.orgEvents[boardId].cards[cardId].tasks.removeAt(taskId);
  //   TasksRepo().setHistory(storage!.completedTasks);
  // }

  String formattedTime(int countdown) {
    int sec = countdown % 60;
    int min = ((countdown / 60) % 60).floor();
    int hrs = (countdown / 60 / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    String hour = hrs.toString().length <= 1 ? "0$hrs" : "$hrs";
    return "$hour:$minute:$second";
  }
}
