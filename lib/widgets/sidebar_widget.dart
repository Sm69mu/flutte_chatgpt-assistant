import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_assistant/constants/consts.dart';

// ignore: camel_case_types
class Sidebar_widget extends StatelessWidget {
  const Sidebar_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Pallete.whiteColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            Padding(padding: EdgeInsets.zero),
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(color: Pallete.whiteColor),
                    accountName: Text('Soumyajit',
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Cera-Pro',
                            color: Color.fromARGB(255, 0, 0, 0))),
                    accountEmail: Text(
                      "soumyajitmukherjee271@gmail.com",
                      style: TextStyle(
                          fontFamily: 'Cera-Pro',
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/images/undraw_Pic_profile_re_7g2h.png"),
                    ))),
            ListTile(
              leading: Icon(
                Icons.add,
                color: Colors.black,
              ),
              title: Text(
                "New Chat ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cera-Pro',
                    color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
              title: Text(
                "Search",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cera-Pro',
                    color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.history_rounded,
                color: Colors.black,
              ),
              title: Text(
                "History",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cera-Pro',
                    color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cera-Pro',
                    color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline_rounded,
                color: Colors.black,
              ),
              title: Text(
                "Help Center",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cera-Pro',
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
