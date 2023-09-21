import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_assistant/constants/consts.dart';
import 'package:flutter_chatgpt_assistant/pages/home_page.dart';
import 'package:flutter_chatgpt_assistant/pages/login_page.dart';
import 'package:flutter_chatgpt_assistant/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Chat Assistant',
        theme: ThemeData(
          useMaterial3: true,
        ).copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
        routes: {
          "/":(context) => const login_page(),
          MyRoutes.homeRoutes:(context) => const Home_page(title: '',),
          MyRoutes.loginRoutes:(context) => const login_page()
        },
        
        );
  }
}
