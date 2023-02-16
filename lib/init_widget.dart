import 'package:flutter/material.dart';
import 'package:innon/pages/board_list/board_list_provider.dart';
import 'package:innon/pages/create_task/create_task_provider.dart';
import 'package:innon/pages/kanban/kanban_provider.dart';
import 'package:innon/pages/main/main_page_provider.dart';
import 'package:innon/pages/task_info/task_info_provider.dart';
import 'package:provider/provider.dart';

class InitWidget extends StatelessWidget {
  const InitWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainPageProvider()),
        ChangeNotifierProvider(create: (context) => BoardListProvider()),
        ChangeNotifierProxyProvider<BoardListProvider, KanbanProvider>(
          create: (_) => KanbanProvider(),
          update: (_, data, player) => player!..update(data),
        ),
        ChangeNotifierProvider(create: (context) => CreateTaskProvider()),
        ChangeNotifierProxyProvider<BoardListProvider, TaskInfoProvider>(
          create: (_) => TaskInfoProvider(),
          update: (_, data, player) => player!..update(data),
        ),
      ],
      child: child,
    );
  }
}
