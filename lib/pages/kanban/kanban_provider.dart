import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innon/data/board/board.dart';
import 'package:innon/data/card/card.dart';
import 'package:innon/data/completed_task/completed_task.dart';
import 'package:innon/data/completed_tasks/completed_tasks.dart';
import 'package:innon/data/relation/relation.dart';
import 'package:innon/pages/board_list/board_list_provider.dart';
import 'package:innon/pages/create_board/create_board_repo.dart';
import 'package:innon/pages/kanban/kanban_repo.dart';
import 'package:innon/pages/tasks/tasks_repo.dart';

import '../../data/task/task.dart';

class KanbanProvider extends ChangeNotifier {
  // final Board board;

  List<BoardCard> _items = [];
  List<BoardCard> get items => _items;
  BoardListProvider? boardInit;
  // KanbanProvider({required this.board}) : _items = List.of(board.cards) {
  //   for (int i = 0; i < items.length; i++) {
  //     items[i].tasks = List.of(board.cards[i].tasks);
  //   }
  // }

  void update(BoardListProvider data) {
    boardInit = data;
  }

  final TasksRepo _tasksRepo = TasksRepo();

  List<CompletedTask> completedTasks = [];
  CompletedTasks _c = CompletedTasks();
  CompletedTasks get c => _c;

  void loadTaskHistory() async {
    _c = await _tasksRepo.getHistory();
    completedTasks = _c.completedTasks!;
    print('COMPssssssss${completedTasks.length}');
    notifyListeners();
  }

  // set items(List<BoardCard> taskModelList) {
  //   _items = taskModelList;
  //   notifyListeners();
  // }

  void setItems(List<BoardCard> taskModelList) {
    _items = taskModelList;
    notifyListeners();
  }

  void addTask({
    required int column,
    required String title,
  }) {
    final task = Task(title: title);
    items[column].tasks.add(task);
    notifyListeners();
  }

  void deleteTask({
    required int column,
    required Task task,
  }) {
    items[column].tasks.remove(task);
    notifyListeners();
  }

  void closeTask(
    int countDown,
    int cardId,
    Task task,
  ) {
    final tasks = items[cardId].tasks;
    final completedTask = CompletedTask(
      title: task.title,
      completionDate: DateTime.now(),
      timeSpent: formattedTime(countDown),
    );
    tasks.remove(task);

    notifyListeners();

    completedTasks.add(completedTask);
    TasksRepo().setHistory(completedTasks);
  }

  String formattedTime(int countdown) {
    int sec = countdown % 60;
    int min = ((countdown / 60) % 60).floor();
    int hrs = (countdown / 60 / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    String hour = hrs.toString().length <= 1 ? "0$hrs" : "$hrs";
    return "$hour:$minute:$second";
  }

  void moveTask({
    required int column,
    required Relation data,
  }) {
    items[data.from].tasks.remove(data.task);
    items[column].tasks.add(data.task);
    notifyListeners();
  }

  void arrangeTask({
    required int column,
    required int from,
    required int to,
  }) {
    final task = items[column].tasks[from];
    items[column].tasks.remove(task);
    items[column].tasks.insert(to, task);
    notifyListeners();
  }

  void addColumn({required String title}) {
    final boardCard = BoardCard(
      title: title,
      tasks: [],
    );
    items.add(boardCard);
    notifyListeners();
  }

  Board saveChanges(Board b) {
    final updatedBoard = Board(
      title: b.title,
      cards: items,
      index: b.index,
      backgroundIndex: b.backgroundIndex,
    );
    boardInit?.orgEvents[b.index] = updatedBoard;
    KanbanRepo().boardCardList(items, b.index);

    return updatedBoard;
  }

  ////TASKINFO
  ///
  Timer? _timer;

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
    final task = items[cardId].tasks[taskId];
    if (task.isTimerRunning) {
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
    final task = items[cardId].tasks[taskId];
    task.isTimerRunning = isTimerRunning;
    task.dateTimeEntry = DateTime.now();
    task.countDown = _countdown;
    task.description = description;
    task.title = title;

    CreateBoardRepo().updateBoardCard(items, boardId);
  }
}
