import 'package:coursework/bottom_menu/cubit/bottom_menu_cubit.dart';
import 'package:coursework/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messager_repository/messager_repository.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pageNavigation = [
    Text('1'),
    Text('2'),
    ChatModule(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomMenuCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    /// Check if index is in range
    /// else return Not Found widget
    ///
    return _pageNavigation.elementAt(index);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: context.read<BottomMenuCubit>().state,
      type: BottomNavigationBarType.fixed,
      onTap: _getChangeBottomNav,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.school), label: "Teach"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Learn"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomMenuCubit>().updateIndex(index);
  }
}
