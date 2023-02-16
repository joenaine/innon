import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innon/pages/board_list/board_list_page.dart';
import 'package:innon/pages/kanban/kanban_provider.dart';
import 'package:innon/pages/main/main_page_provider.dart';
import 'package:innon/pages/register/auth.dart';
import 'package:innon/pages/register/register_screen.dart';
import 'package:innon/pages/tasks/tasks_page.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/firebase_consts.dart';
import 'package:innon/resources/styles.dart';
import 'package:innon/widgets/app_global_loader_widget.dart';
import 'package:provider/provider.dart';

final user = authInstance.currentUser;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    loadHistoryPage();
    super.initState();
  }

  void loadHistoryPage() {
    final kanbanInit = Provider.of<KanbanProvider>(context, listen: false);
    kanbanInit.loadTaskHistory();
  }

  @override
  Widget build(BuildContext context) {
    final mInit = Provider.of<MainPageProvider>(context);
    return StreamBuilder<User?>(
        stream: AuthRepository().authState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: AppColors.bg,
              body: Center(
                child: AppLoaderWidget(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && user != null) {
              return Scaffold(
                backgroundColor: AppColors.bg,
                body: mInit.currentIndex == 0
                    ? const BoardListPage()
                    : const TasksPage(),
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Palette.white,
                        width: 0.1,
                      ),
                    ),
                  ),
                  child: BottomNavigationBar(
                    selectedFontSize: 0,
                    currentIndex: mInit.currentIndex,
                    onTap: (index) {
                      mInit.setCurrentIndex(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.border_all_rounded,
                          size: 32,
                        ),
                        label: 'board',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.tab,
                          size: 32,
                        ),
                        label: 'tasks',
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const RegisterScreen();
            }
          } else {
            return Center(
              child: Text('State: ${snapshot.connectionState}'),
            );
          }
        });
  }
}