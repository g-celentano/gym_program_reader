import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'palette.dart';
import 'organizza_scheda.dart';

extension StringCasingExtension on String {
  String capitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String capitalizeEach() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}

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
  List<String> content = List.empty(growable: true);
  List<List<String>> allenamenti = List.empty(growable: true);
  Iterable<String> giorni = List.empty(growable: true);
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    giorni =
        content.where((element) => element.toUpperCase().contains('GIORNO'));

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
        actions: giorni
            .map((element) => GestureDetector(
                  onTap: () => setState(() {
                    selectedDay = giorni.toList().indexOf(element);
                  }),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedDay == giorni.toList().indexOf(element)
                          ? Palette.black.shade100
                          : Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11.0),
                      child: Center(
                        child: Text(
                          element.split(' ').last,
                          style: TextStyle(
                              color: isDarkMode ? Palette.black : Palette.white,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: isDarkMode ? Palette.black.shade600 : Palette.white,
          ),
          Center(
            child: OrganizzaScehda(
              content: content,
              isDarkMode: isDarkMode,
            ),
          ),
        ]),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Palette.primaryColor,
        overlayColor:
            isDarkMode ? Palette.black.shade50 : Palette.white.shade50,
        spaceBetweenChildren: 20,
        children: [
          SpeedDialChild(
              label: 'Carica Scheda',
              labelBackgroundColor: Palette.primaryColor,
              labelStyle: const TextStyle(fontSize: 16, color: Palette.black),
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  scheda = File(result.files.single.path.toString());
                  List<String> temp =
                      await scheda.readAsLines(encoding: latin1);
                  setState(() {
                    content = temp;
                  });
                }
              },
              child: const Icon(
                Ionicons.document_outline,
                size: 30,
              )),
          SpeedDialChild(
              label: 'Esercizio Occasionale',
              labelBackgroundColor: Palette.primaryColor,
              labelStyle: const TextStyle(fontSize: 16, color: Palette.black),
              onTap: () {},
              child: const Icon(
                Ionicons.barbell,
                size: 30,
              )),
        ],
      ),
    );
  }
}
