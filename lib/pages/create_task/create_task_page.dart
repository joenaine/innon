import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innon/data/board/board.dart';
import 'package:innon/pages/create_task/create_task_provider.dart';
import 'package:innon/pages/kanban/kanban_provider.dart';
import 'package:innon/resources/app_assets.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';
import 'package:innon/widgets/general_button.dart';
import 'package:innon/widgets/textfields.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_hide_keyboard_widget.dart';

class CreateTaskPage extends StatefulWidget {
  final int cardId;
  final Board board;
  const CreateTaskPage({Key? key, required this.cardId, required this.board})
      : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController controller = TextEditingController();
  bool isCreateButtonActive = false;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardCardInit = Provider.of<KanbanProvider>(context);
    final createTaskInit = Provider.of<CreateTaskProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        boardCardInit.saveChanges(widget.board);
        return Future(() => true);
      },
      child: AppHideKeyBoardWidget(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  left: 22.w,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(AppAssets.svg.xcircle)),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFieldGlobal(
                      controller: controller,
                      hintText: 'New Task',
                      onChanged: (value) {
                        if (controller.text.isNotEmpty) {
                          isCreateButtonActive = true;
                        } else {
                          isCreateButtonActive = false;
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Inside: ',
                          style: AppStyles.s16w400,
                        ),
                        Text(
                          boardCardInit.items[widget.cardId].title,
                          style: AppStyles.s16w400
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: GeneralButton(
                  color: isCreateButtonActive
                      ? AppColors.primary
                      : AppColors.disabled,
                  fontSize: 16,
                  text: 'Save',
                  onPressed: () {
                    if (isCreateButtonActive) {
                      boardCardInit.addTask(
                          column: widget.cardId, title: controller.text);
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
