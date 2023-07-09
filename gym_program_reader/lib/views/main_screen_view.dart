import 'package:flutter/material.dart';
import 'package:gym_program_reader/views/Widgets/appbar.dart';
import 'package:gym_program_reader/views/Widgets/main_scree_body.dart';

import '../palette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width, height * 0.065),
          child: AppBarContent(isDarkMode: isDarkMode)),
      body: Container(
          color: Palette().getSixtyPercent(isDarkMode),
          width: width,
          height: height,
          child: HomeScreenBody(isDarkMode: isDarkMode)),
    );
  }
}
