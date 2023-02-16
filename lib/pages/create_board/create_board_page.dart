import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innon/data/board/board.dart';
import 'package:innon/pages/board_list/board_list_provider.dart';
import 'package:innon/pages/kanban/kanban_page.dart';
import 'package:innon/resources/app_assets.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/images.dart';
import 'package:innon/resources/screen_navigation_const.dart';
import 'package:innon/resources/styles.dart';
import 'package:innon/widgets/app_divider.dart';
import 'package:innon/widgets/app_hide_keyboard_widget.dart';
import 'package:innon/widgets/textfields.dart';
import 'package:provider/provider.dart';

class CreateBoardPage extends StatefulWidget {
  const CreateBoardPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateBoardPage> createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  TextEditingController controller = TextEditingController();
  bool isCreateButtonActive = false;

  @override
  Widget build(BuildContext context) {
    final boardInit = Provider.of<BoardListProvider>(context);
    return AppHideKeyBoardWidget(
      child: Scaffold(
        backgroundColor: AppColors.bg,
        appBar: AppBar(
          title: const Text('Board'),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 22.w,
              ),
              child: GestureDetector(
                onTap: (() {
                  if (isCreateButtonActive) {
                    final newBoard = Board(
                      title: controller.text,
                      cards: [],
                      index: boardInit.orgEvents.length,
                      backgroundIndex: boardInit.selectedBackgroundIndex,
                    );
                    boardInit.addBoard(newBoard);
                    changeScreenPopAndPush(
                        context, KanbanPage(board: boardInit.orgEvents.last));
                    boardInit.loadOrgEvents();
                  }
                }),
                child: Center(
                    child: Text(
                  'Create',
                  style: TextStyles.textSize18Weight600.copyWith(
                    color: isCreateButtonActive
                        ? AppColors.primary
                        : AppColors.grayLight,
                  ),
                )),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              child: CustomTextFieldGlobal(
                controller: controller,
                hintText: 'New Board',
                onChanged: (value) {
                  if (controller.text.isNotEmpty) {
                    isCreateButtonActive = true;
                    setState(() {});
                  } else {
                    isCreateButtonActive = false;
                    setState(() {});
                  }
                },
              ),
            ),
            const AppDivider(),
            SizedBox(
              height: 49.h,
            ),

            Center(
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 40,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return boardInit.selectedBackgroundIndex == index
                        ? Stack(
                            children: [
                              Container(
                                height: 40.w,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.r),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage('$images/bc$index.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  child: SvgPicture.asset(
                                AppAssets.svg.check,
                                color: AppColors.white,
                              )),
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              boardInit.selectBackground(index);
                            },
                            child: Container(
                              height: 40.w,
                              width: 40.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.r),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('$images/bc$index.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
            // InkWell(
            //   highlightColor: Palette.darkBlue,
            //   onTap: () {
            //     context.router.push(
            //       ChooseBackgroundRoute(
            //         createBoardPageStore: pageStore,
            //       ),
            //     );
            //   },
            //   child: Container(
            //     color: AppColors.green,
            //     padding: EdgeInsets.symmetric(
            //       horizontal: 16.w,
            //       vertical: 16.h,
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         TextSize.s16w500('Background'),

            //         // Observer(builder: (context) {
            //         //   return Container(
            //         //     height: 22.w,
            //         //     width: 22.w,
            //         //     decoration: BoxDecoration(
            //         //       borderRadius: BorderRadius.all(
            //         //         Radius.circular(4.r),
            //         //       ),
            //         //       image: DecorationImage(
            //         //         image: AssetImage(
            //         //             '$images/bc${pageStore.selectedBackgroundIndex}.jpg'),
            //         //         fit: BoxFit.fill,
            //         //       ),
            //         //     ),
            //         //   );
            //         // }),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
