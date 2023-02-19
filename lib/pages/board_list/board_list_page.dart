import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innon/pages/create_board/create_board_page.dart';
import 'package:innon/pages/kanban/kanban_page.dart';
import 'package:innon/pages/kanban/kanban_provider.dart';
import 'package:innon/pages/register/auth.dart';
import 'package:innon/resources/app_assets.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';
import 'package:innon/resources/firebase_consts.dart';
import 'package:innon/resources/images.dart';
import 'package:innon/resources/screen_navigation_const.dart';
import 'package:innon/widgets/app_global_loader_widget.dart';
import 'package:provider/provider.dart';

import 'board_list_provider.dart';
import 'widgets/board_tile.dart';
import 'widgets/preview.dart';

final firestore = FirebaseFirestore.instance;

class BoardListPage extends StatefulWidget {
  const BoardListPage({Key? key}) : super(key: key);

  @override
  State<BoardListPage> createState() => _BoardListPageState();
}

class _BoardListPageState extends State<BoardListPage> {
  @override
  void initState() {
    // pageStore.loadPage();
    getBoardList();
    super.initState();
  }

  Future<void> getBoardList() async {
    final org = context.read<BoardListProvider>();
    org.loadOrgEvents();
  }

  @override
  Widget build(BuildContext context) {
    final boardInit = Provider.of<BoardListProvider>(context);
    final boardCardInit = Provider.of<KanbanProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.white,
          child: SvgPicture.asset(AppAssets.svg.add),
          onPressed: () {
            changeScreen(context, const CreateBoardPage());
          },
        ),
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  AuthRepository().signOut();
                  authInstance.signOut();
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: boardInit.orgEvents.isEmpty
            ? AppLoaderWidget()
            : boardInit.orgEvents.length.toString() == "0"
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
                : RefreshIndicator(
                    onRefresh: () {
                      return getBoardList();
                    },
                    child: ListView.separated(
                      itemCount: boardInit.orgEvents.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            changeScreen(context,
                                KanbanPage(board: boardInit.orgEvents[index]));
                            boardCardInit
                                .setItems(boardInit.orgEvents[index].cards);
                            // boardCardInit.items =
                            //     boardInit.orgEvents[index].cards;
                          },
                          child: BoardListTile(
                            title: boardInit.orgEvents[index].title,
                            preview: Preview(
                              imagePath:
                                  '$images/${boardInit.orgEvents[index].backgroundIndex}.jpg',
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                    ),
                  ));
  }
}
