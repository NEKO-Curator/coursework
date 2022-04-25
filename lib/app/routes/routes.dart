import 'package:coursework/app/app.dart';
import 'package:coursework/bottom_menu/view/view.dart';
import 'package:coursework/login/login.dart';
import 'package:flutter/widgets.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [BottomNavBarPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
