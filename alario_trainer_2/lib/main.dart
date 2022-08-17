import 'dart:io';
import 'package:flutter/material.dart';
import 'palette.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alario Trainer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.primaryColor,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool isDarkMode;
  late File scheda;
  String content = '';

  @override
  Widget build(BuildContext context) {
    isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width / 4,
        leading: isDarkMode
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/imgs/LogoDarkMode.png"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/imgs/LogoLightMode.png"),
              ),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: isDarkMode ? Palette.black.shade600 : Palette.white,
          ),
        ]),
      ),
    );
  }
}
