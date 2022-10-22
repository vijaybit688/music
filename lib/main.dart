import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music/ui/book_mark_screen.dart';
import 'package:music/ui/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'colors.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('bookMark');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int indexValue = 0;
  List<Widget> screenList = [HomeScree(), BookMarkScreen()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: DEEP_PURPLE,
          title: const Text(
            "Music App",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: LIGHT_PURPLE,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: LIGHT_PURPLE,
          color: DEEP_PURPLE,
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.book,
              color: Colors.white,
            )
          ],
          index: indexValue,
          onTap: (value) {
            setState(() {
              indexValue = value;
            });
          },
        ),
        body: screenList[indexValue],
      ),
    );
  }
}
