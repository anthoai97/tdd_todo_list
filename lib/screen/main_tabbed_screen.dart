import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttd_todo_list/di/injection_container.dart';
import 'package:ttd_todo_list/features/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:ttd_todo_list/features/todo_list/presentation/page/todo_page.dart';
import 'package:ttd_todo_list/features/todo_list/presentation/widget/create_task_dialog.dart';
import 'package:ttd_todo_list/themes/styles.dart';

class MainTabbedScreen extends StatefulWidget {
  const MainTabbedScreen({Key? key}) : super(key: key);

  @override
  _MainTabbedScreenState createState() => _MainTabbedScreenState();
}

class _MainTabbedScreenState extends State<MainTabbedScreen>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = [
      BottomNavigationBarItem(
        label: "All",
        icon: const Icon(Icons.list),
        activeIcon: Icon(
          Icons.list,
          color: AppColors.primary,
        ),
      ),
      BottomNavigationBarItem(
        label: "Complete",
        icon: const Icon(Icons.check),
        activeIcon: Icon(
          Icons.check,
          color: AppColors.primary,
        ),
      ),
      BottomNavigationBarItem(
        label: "Incomplete",
        icon: const Icon(Icons.clear),
        activeIcon: Icon(
          Icons.clear,
          color: AppColors.primary,
        ),
      ),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateTaskDialog(context, submitFunction: (content) {
            print(content);
          });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        backgroundColor: Colors.white,
        elevation: 2,
        selectedLabelStyle: TextStyle(color: AppColors.primary, fontSize: 9),
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 8),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        mouseCursor: SystemMouseCursors.none,
      ),
      body: BlocProvider(
        create: (context) => sl<TodoBloc>(),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: items.map((BottomNavigationBarItem e) {
            int index = items.indexOf(e);
            return _bodyForTab(context, index);
          }).toList(),
        ),
      ),
    );
  }

  Widget _bodyForTab(BuildContext context, int index) {
    var body;
    switch (index) {
      case 0:
        body = const TodoPage(
          title: 'Todo App',
        );
        break;
      case 1:
        body = Container();
        break;
      case 2:
        body = Container();
        break;
      default:
        body = Container();
    }
    return body;
  }

  @override
  bool get wantKeepAlive => true;
}
