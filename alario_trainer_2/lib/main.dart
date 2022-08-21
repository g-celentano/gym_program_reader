import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'palette.dart';
import 'organizza_scheda.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension StringCasingExtension on String {
  String capitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String capitalizeEach() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool darkModeSync = prefs.getBool("isDarkModeSynched") ?? false;
  bool darkModeEnabled = prefs.getBool("isDarkModeEnabled") ?? false;
  runApp(MainPage(
    darkModeSync: darkModeSync,
    darkModeEnabled: darkModeEnabled,
  ));
}

class MainPage extends StatelessWidget {
  const MainPage(
      {Key? key, required this.darkModeSync, required this.darkModeEnabled})
      : super(key: key);
  final bool darkModeSync;
  final bool darkModeEnabled;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alario Trainer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.primaryColor,
      ),
      home: MyHomePage(
        darkModeSync: darkModeSync,
        darkModeEnabled: darkModeEnabled,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.darkModeSync, required this.darkModeEnabled})
      : super(key: key);
  final bool darkModeSync;
  final bool darkModeEnabled;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkMode = false;
  bool systemSync = false;
  late File scheda;
  List<List<String>> allenamenti = List.empty(growable: true);
  List<String> giorni = List.empty(growable: true);
  int selectedDay = 0;

  int initialIndex = 0;

  @override
  void initState() {
    super.initState();
    systemSync = widget.darkModeSync;
    isDarkMode = widget.darkModeEnabled;
  }

  @override
  Widget build(BuildContext context) {
    if (systemSync) {
      isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

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
                    selectedDay = giorni.indexOf(element);
                  }),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedDay == giorni.indexOf(element)
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
              allenamento:
                  allenamenti.isNotEmpty ? allenamenti[selectedDay] : [],
              isDarkMode: isDarkMode,
            ),
          ),
        ]),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Palette.primaryColor,
        foregroundColor: isDarkMode ? Palette.black : Palette.white,
        overlayColor: isDarkMode ? Palette.black : Palette.white,
        spaceBetweenChildren: 20,
        children: [
          SpeedDialChild(
              label: 'Carica Scheda',
              labelShadow:
                  isDarkMode ? null : const [BoxShadow(color: Palette.white)],
              labelBackgroundColor:
                  isDarkMode ? Palette.primaryColor : Colors.transparent,
              labelStyle: const TextStyle(fontSize: 16, color: Palette.black),
              backgroundColor:
                  isDarkMode ? Palette.white : Palette.primaryColor,
              foregroundColor: isDarkMode ? Palette.black : Palette.white,
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  scheda = File(result.files.single.path.toString());
                  giorni = List.empty(growable: true);
                  allenamenti = List.empty(growable: true);
                  List<String> content =
                      await scheda.readAsLines(encoding: latin1);
                  setState(() {
                    selectedDay = 0;
                    giorni = content
                        .where((element) =>
                            element.toUpperCase().contains('GIORNO'))
                        .toList();
                    for (int i = 0; i < giorni.length; i++) {
                      if (i != giorni.length - 1) {
                        allenamenti.add(content.sublist(
                            content.indexOf(giorni[i]),
                            content.indexOf(giorni[i + 1])));
                      } else {
                        allenamenti
                            .add(content.sublist(content.indexOf(giorni[i])));
                      }
                    }
                  });
                }
              },
              child: const Icon(
                Ionicons.document_outline,
                size: 30,
              )),
          SpeedDialChild(
              label: 'Esercizio Occasionale',
              labelShadow:
                  isDarkMode ? null : const [BoxShadow(color: Palette.white)],
              labelBackgroundColor:
                  isDarkMode ? Palette.primaryColor : Colors.transparent,
              labelStyle: const TextStyle(fontSize: 16, color: Palette.black),
              backgroundColor:
                  isDarkMode ? Palette.white : Palette.primaryColor,
              foregroundColor: isDarkMode ? Palette.black : Palette.white,
              onTap: () {},
              child: const Icon(
                Ionicons.barbell,
                size: 30,
              )),
          SpeedDialChild(
            label: 'Aspetto',
            labelShadow:
                isDarkMode ? null : const [BoxShadow(color: Palette.white)],
            labelBackgroundColor:
                isDarkMode ? Palette.primaryColor : Colors.transparent,
            labelStyle: const TextStyle(fontSize: 16, color: Palette.black),
            child: SpeedDial(
              spaceBetweenChildren: 20,
              backgroundColor:
                  isDarkMode ? Palette.white : Palette.primaryColor,
              foregroundColor: isDarkMode ? Palette.black : Palette.white,
              icon: Ionicons.eye,
              iconTheme: const IconThemeData(size: 30),
              children: [
                SpeedDialChild(
                    label: 'Light/Dark Mode',
                    labelShadow: isDarkMode
                        ? null
                        : const [BoxShadow(color: Palette.white)],
                    labelBackgroundColor:
                        isDarkMode ? Palette.primaryColor : Colors.transparent,
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Palette.black),
                    backgroundColor:
                        isDarkMode ? Palette.white : Palette.primaryColor,
                    foregroundColor: isDarkMode ? Palette.black : Palette.white,
                    onTap: () async {
                      setState(() {
                        isDarkMode = !isDarkMode;
                      });
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isDarkModeEnabled", isDarkMode);
                    },
                    child: Icon(
                      isDarkMode ? Ionicons.moon : Ionicons.sunny,
                      size: 30,
                    )),
                SpeedDialChild(
                    label: 'Sincronizza Col Telefono',
                    labelShadow: isDarkMode
                        ? null
                        : const [BoxShadow(color: Palette.white)],
                    labelBackgroundColor:
                        isDarkMode ? Palette.primaryColor : Colors.transparent,
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Palette.black),
                    backgroundColor:
                        isDarkMode ? Palette.white : Palette.primaryColor,
                    foregroundColor: isDarkMode ? Palette.black : Palette.white,
                    onTap: () async {
                      setState(() {
                        systemSync = !systemSync;
                      });
                      final prefs = await SharedPreferences.getInstance();
                      if (systemSync) {
                        prefs.setBool('isDarkModeSynched', true);
                        setState(() {
                          isDarkMode =
                              MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark;
                        });
                      } else {
                        prefs.setBool('isDarkModeSynched', false);
                      }
                    },
                    child: Icon(
                      systemSync ? Ionicons.checkmark : Ionicons.close,
                      size: 30,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
