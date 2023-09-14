import 'package:flutter_chatgpt_assistant/pages/home_page.dart';
import 'package:flutter_chatgpt_assistant/constants/consts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Assistant',
        theme: ThemeData(
          useMaterial3: true,
        ).copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
        home: const Homepage(
          title: '',
        ));
  }
}
