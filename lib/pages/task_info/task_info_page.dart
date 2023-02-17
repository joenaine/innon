import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/data/task/task.dart';
import 'package:innon/pages/kanban/kanban_provider.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';
import 'package:innon/resources/styles.dart';
import 'package:innon/services/text_fontsize.dart';
import 'package:innon/widgets/app_hide_keyboard_widget.dart';
import 'package:innon/widgets/discolored_button.dart';
import 'package:innon/widgets/general_button.dart';
import 'package:innon/widgets/textfields.dart';
import 'package:provider/provider.dart';

class TaskInfoPage extends StatefulWidget {
  final int boardId;
  final int cardId;
  final int taskId;
  final String title;
  final String description;
  final String inList;
  final Task? task;

  const TaskInfoPage(
      {Key? key,
      required this.boardId,
      required this.cardId,
      required this.taskId,
      required this.title,
      required this.description,
      required this.inList,
      this.task})
      : super(key: key);

  @override
  State<TaskInfoPage> createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage> {
  late final TextEditingController titleController;

  late final TextEditingController descriptionController;

  @override
  void initState() {
    final kanbanInit = Provider.of<KanbanProvider>(context, listen: false);
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    kanbanInit.loadTask(widget.boardId, widget.cardId, widget.taskId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final taskInit = Provider.of<TaskInfoProvider>(context);
    final kanbanInit = Provider.of<KanbanProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        if (kanbanInit.canUpdateTask) {
          kanbanInit.updateTask(
            widget.boardId,
            widget.cardId,
            widget.taskId,
            titleController.text,
            descriptionController.text,
          );
        }
        return Future.value(true);
      },
      child: AppHideKeyBoardWidget(
        child: Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(
                left: 22.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (kanbanInit.canUpdateTask) {
                      kanbanInit.updateTask(
                        widget.boardId,
                        widget.cardId,
                        widget.taskId,
                        titleController.text,
                        descriptionController.text,
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 22.w,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      kanbanInit.deleteTask(
                          column: widget.cardId, task: widget.task!);

                      kanbanInit.canUpdateTask = false;
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.delete_outlined,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    color: AppColors.white,
                    child: Column(
                      children: [
                        CustomTextFieldGlobal(
                          controller: titleController,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Inside: ',
                              style: AppStyles.s16w400,
                            ),
                            Text(
                              widget.inList,
                              style: AppStyles.s16w400
                                  .copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSize.s18w700('Description'),
                        const SizedBox(height: 8),
                        CustomTextFieldGlobal(
                          controller: descriptionController,
                          maxlines: 8,
                          keyboardType: TextInputType.multiline,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.all(16),
                    color: AppColors.white,
                    child: widget.task!.users != null
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.task!.users!.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 5);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return CircleAvatar(
                                backgroundColor: AppColors.grayLight,
                                backgroundImage: NetworkImage(
                                    widget.task!.users![index].photo!),
                              );
                            },
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: TextSize.s18w700('Users not selected'),
                          ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextSize.s18w700('Timer'),
                        const SizedBox(height: 8),
                        Container(
                          color: AppColors.dark,
                          child: Center(
                              child: Text(
                            kanbanInit.formattedTime(kanbanInit.countdown),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.textSize48Weight400.copyWith(
                              color: Palette.white,
                            ),
                          )),
                        ),
                        SizedBox(height: 16.h),
                        Center(
                            child: kanbanInit.isTimerRunning
                                ? SizedBox(
                                    width: 100,
                                    child: DiscoloredButton(
                                        text: 'Stop',
                                        onPressed: () {
                                          if (kanbanInit.isTimerRunning) {
                                            kanbanInit.stopTimer();
                                          } else {
                                            kanbanInit.startTimer();
                                          }
                                        }))
                                : SizedBox(
                                    width: 100,
                                    child: GeneralButton(
                                        fontSize: 16,
                                        text: 'Start',
                                        onPressed: () {
                                          if (kanbanInit.isTimerRunning) {
                                            kanbanInit.stopTimer();
                                          } else {
                                            kanbanInit.startTimer();
                                          }
                                        }))),
                        SizedBox(
                          height: 12.h,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              kanbanInit.closeTask(
                                kanbanInit.countdown,
                                widget.cardId,
                                widget.task!,
                              );
                              kanbanInit.canUpdateTask = false;

                              Navigator.pop(context);
                            },
                            child: Text(
                              'Close Task',
                              style: AppStyles.s18w700
                                  .copyWith(color: AppColors.gray),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
