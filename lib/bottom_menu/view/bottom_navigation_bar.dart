import 'package:coursework/bottom_menu/cubit/bottom_menu_cubit.dart';
import 'package:coursework/bottom_menu/view/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarPage extends StatelessWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: BottomNavBarPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   centerTitle: true,
      //   backgroundColor: appBarColor,
      // ),
      body: BlocProvider(
        create: (_) => BottomMenuCubit(),
        child: const BottomNavBar(),
      ),
    );
  }
}
