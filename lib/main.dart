import 'package:flutter/material.dart';

import 'package:molham/utiltes/themes/mode_color_screen.dart';
import 'package:molham/view/components/menu.dart';
import 'package:molham/view/components/navbar.dart';
import 'package:molham/view/screens/HomeScreen.dart';
import 'package:molham/view/screens/chatgpt.dart';
import 'package:molham/view/screens/features/Weather/screens/Weather.dart';
import 'package:molham/view/screens/sleepmode.dart';
import 'package:molham/view/screens/settings.dart';
import 'package:molham/view/screens/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Light theme
      routes: {
        "Sleepmode": (context) => Sleepmode(),
        "Settings": (context) => Settings(),
        "Navbar": (context) => Navbar(),
        "chatgpt": (context) => Chatgpt(texty: 'اهلا بك في ملهم',)
      },
      home: HomeScreen(),
    );
  }
}
