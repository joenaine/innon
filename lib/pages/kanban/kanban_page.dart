import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/data/board/board.dart';
import 'package:innon/data/relation/relation.dart';
import 'package:innon/data/task/task.dart';
import 'package:innon/pages/create_task/create_task_page.dart';
import 'package:innon/pages/kanban/widgets/add_column_button_widget.dart';
import 'package:innon/pages/kanban/widgets/add_column_widget.dart';
import 'package:innon/pages/kanban/widgets/column_widget.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/images.dart';
import 'package:innon/resources/screen_navigation_const.dart';
import 'package:innon/resources/styles.dart';
import 'package:provider/provider.dart';

import 'kanban_provider.dart';

class KanbanPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final Board board;

  KanbanPage({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    final boardCardInit = Provider.of<KanbanProvider>(context);
    print('LENGTH${boardCardInit.items.length}');
    return WillPopScope(
      onWillPop: () {
        boardCardInit.saveChanges(board);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Palette.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.white),
          title: Text(
            board.title,
            style: const TextStyle(color: AppColors.white),
          ),
          centerTitle: false,
          backgroundColor: Palette.transparent,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('$images/${board.backgroundIndex}.jpg'),
            ),
          ),
          child: SafeArea(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: boardCardInit.items.length + 1,
              itemBuilder: (context, index) {
                print('LENGTH${boardCardInit.items.length}');
                if (index == boardCardInit.items.length) {
                  return AddColumnButton(
                    key: UniqueKey(),
                    addColumnAction: () => _showAddColumn(context),
                  );
                } else {
                  return KanbanColumn(
                    key: UniqueKey(),
                    column: boardCardInit.items[index],
                    index: index,
                    dragHandler: (Relation data, int currentIndex) =>
                        _handleDrag(context, data, currentIndex),
                    reorderHandler:
                        (int oldIndex, int newIndex, int columnIndex) =>
                            _handleReOrder(
                                context, oldIndex, newIndex, columnIndex),
                    addTaskHandler: (int index) =>
                        _showAddTask(context, index, board),
                    dragListener: (PointerMoveEvent event) =>
                        _dragListener(context, event),
                    deleteItemHandler: (int index, Task task) =>
                        _deleteItem(context, index, task),
                    boardId: board.index,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _dragListener(BuildContext context, PointerMoveEvent event) {
    if (event.position.dx > MediaQuery.of(context).size.width - 20.w) {
      _scrollController.jumpTo(_scrollController.offset + 10.w);
    } else if (event.position.dx < 20.w) {
      _scrollController.jumpTo(_scrollController.offset - 10.w);
    }
  }

  void _showAddColumn(BuildContext context) {
    final boardCardInit = Provider.of<KanbanProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AddColumn(
        addColumnHandler: (String title) {
          boardCardInit.addColumn(title: title);
        },
      ),
    );
  }

  void _showAddTask(BuildContext context, int index, Board board) {
    changeScreen(context, CreateTaskPage(cardId: index, board: board));
  }

  void _deleteItem(BuildContext context, int columnIndex, Task task) {
    final boardCardInit = Provider.of<KanbanProvider>(context, listen: false);
    boardCardInit.deleteTask(column: columnIndex, task: task);
  }

  void _handleReOrder(
      BuildContext context, int oldIndex, int newIndex, int index) {
    final boardCardInit = Provider.of<KanbanProvider>(context, listen: false);
    if (oldIndex != newIndex) {
      boardCardInit.arrangeTask(column: index, from: oldIndex, to: newIndex);
    }
  }

  void _handleDrag(BuildContext context, Relation data, int currentIndex) {
    final boardCardInit = Provider.of<KanbanProvider>(context, listen: false);
    boardCardInit.moveTask(column: currentIndex, data: data);
  }
}
