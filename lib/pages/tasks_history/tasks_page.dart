import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innon/data/completed_task/completed_task.dart';
import 'package:innon/pages/kanban/kanban_provider.dart';
import 'package:innon/pages/tasks_history/widgets/export_menu.dart';
import 'package:innon/pages/tasks_history/widgets/task_list_tile.dart';
import 'package:innon/resources/app_assets.dart';
import 'package:innon/resources/app_styles_const.dart';
import 'package:innon/widgets/app_global_loader_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:to_csv/to_csv.dart';

import '../../widgets/app_bar_action.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  double target = 0.0;

  void exportCsv() {
    final kanbanInit = Provider.of<KanbanProvider>(context, listen: false);
    List<List<String>> csvContent = [];
    List<String> csvHeaders = [];
    csvHeaders.add('Task');
    csvHeaders.add('Completion Date');
    csvHeaders.add('Time spent');
    csvContent.add(csvHeaders);
    for (CompletedTask completedTask in kanbanInit.completedTasks) {
      List<String> data = [
        completedTask.title,
        DateFormat.MMMMd().format(completedTask.completionDate),
        completedTask.timeSpent,
      ];
      csvContent.add(data);
    }
    if (csvContent.isEmpty) {
      csvContent.add(['']);
    }
    myCSV(csvHeaders, csvContent);
  }

  void _onTapHandler() {
    target += 1;
    if (target > 1.0) {
      target = 1;
      animationController.reset();
    }
    animationController.animateTo(target);
  }

  @override
  void initState() {
    loadHistoryPage();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation =
        Tween<double>(begin: 0, end: pi * 2).animate(animationController);
    super.initState();
  }

  void loadHistoryPage() {
    final kanbanInit = Provider.of<KanbanProvider>(context, listen: false);
    kanbanInit.loadTaskHistory();
  }

  @override
  Widget build(BuildContext context) {
    final kanbanInit = Provider.of<KanbanProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          actions: [
            AppBarAction(
              icon: Icons.ios_share_outlined,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ExportMenu(
                    exportHandler: exportCsv,
                  ),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _onTapHandler();
            loadHistoryPage();
          },
          child: kanbanInit.completedTasks.isEmpty
              ? AppLoaderWidget()
              : kanbanInit.completedTasks.length.toString() == "0"
                  ? SizedBox(
                      height: 250.0,
                      width: 200.0,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            "Нет документов",
                            style: AppStyles.s16w400,
                          ),
                          SvgPicture.asset(AppAssets.svg.emptyAvatar),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: kanbanInit.completedTasks.length + 1,
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [],
                              )
                            : TaskListTile(
                                title:
                                    kanbanInit.completedTasks[index - 1].title,
                                completionDate: DateFormat.MMMMd().format(
                                    kanbanInit.completedTasks[index - 1]
                                        .completionDate),
                                timeSpent: kanbanInit
                                    .completedTasks[index - 1].timeSpent,
                              );
                      },
                    ),
        ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
