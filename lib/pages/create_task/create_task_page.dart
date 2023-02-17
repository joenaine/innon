import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innon/data/board/board.dart';
import 'package:innon/data/user/user_model.dart';
import 'package:innon/pages/board_list/board_list_page.dart';
import 'package:innon/pages/create_task/create_task_provider.dart';
import 'package:innon/pages/kanban/kanban_provider.dart';
import 'package:innon/resources/app_assets.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';
import 'package:innon/services/send_token.dart';
import 'package:innon/widgets/app_global_loader_widget.dart';
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

  List<String> usersSelected = [];
  List<UserModel> usersModelSelected = [];

  void addToSelectedUsers(String u, UserModel usr) {
    if (usersSelected.contains(u)) {
      usersSelected.remove(u);
      usersModelSelected.remove(usr);
    } else {
      usersSelected.add(u);
      usersModelSelected.add(usr);
    }
    setState(() {});
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
                height: 8.h,
              ),
              FutureBuilder(
                  future: firestore.collection("users").get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserModel> usersList = [];
                      for (QueryDocumentSnapshot<Map<String, dynamic>> e
                          in snapshot.data!.docs) {
                        usersList.add(UserModel.fromFirestore(e));
                      }
                      return Container(
                        height: 80,
                        padding: const EdgeInsets.all(16),
                        color: AppColors.white,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: usersList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 5);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                addToSelectedUsers(
                                    usersList[index].token!, usersList[index]);
                              },
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.grayLight,
                                    backgroundImage:
                                        NetworkImage(usersList[index].photo!),
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: usersSelected
                                              .contains(usersList[index].token)
                                          ? SvgPicture.asset(
                                              AppAssets.svg.checkboxActive,
                                              height: 18)
                                          : SvgPicture.asset(
                                              AppAssets.svg.checkboxInactive,
                                              height: 18)),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 80,
                        padding: const EdgeInsets.all(16),
                        color: AppColors.white,
                        child: AppLoaderWidget(),
                      );
                    }
                  }),
              SizedBox(
                height: 8.h,
              ),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(16),
                child: GeneralButton(
                  color: isCreateButtonActive
                      ? AppColors.primary
                      : AppColors.disabled,
                  fontSize: 16,
                  text: 'Save',
                  onPressed: () {
                    if (isCreateButtonActive) {
                      for (var i = 0; i < usersSelected.length; i++) {
                        SendToken.sendPushMessage(
                            controller.text, 'New Task', usersSelected[i]);
                      }

                      boardCardInit.addTask(
                          column: widget.cardId,
                          title: controller.text,
                          users: usersModelSelected);
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
