import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messager_repository/src/pages/home_page.dart';
import 'package:messager_repository/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    log('init splash State');
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    log('check SIGN in');
    try {
      if (isLoggedIn) {
        log('is logged in');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        return;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Добро пожаловать в чат",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // Image.asset(
            //   'assets/images/img_not_available.jpeg',
            //   // width: 300,
            //   // height: 300,
            // ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Тестовый Модуль Чата",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 159, 159),
            ),
          ],
        ),
      ),
    );
  }
}
