// import 'dart:io';
import 'package:alario_trainer_2/palette.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'timer_page.dart';

class OrganizzaScehda extends StatefulWidget {
  const OrganizzaScehda({
    Key? key,
    required this.allenamento,
    required this.selectedDay,
    required this.isDarkMode,
  }) : super(key: key);

  final List<String> allenamento;
  final bool isDarkMode;
  final ValueNotifier<int> selectedDay;

  @override
  State<OrganizzaScehda> createState() => OrganizzaScehdaState();
}

class OrganizzaScehdaState extends State<OrganizzaScehda> {
  List<String> esercizi = List.empty(growable: true);
  ScrollController controller = ScrollController();
  List<TextEditingController> controllerNote = List.empty(growable: true);
  int indexOnScreen = 0;
  int timer = 15;

  @override
  Widget build(BuildContext context) {
    esercizi = widget.allenamento
        .where((element) =>
            element.isNotEmpty && !element.toUpperCase().contains('GIORNO'))
        .toList();
    for (int i = 0; i < esercizi.length; i++) {
      controllerNote.add(TextEditingController());
    }
    widget.selectedDay.addListener(
      () {
        setState(() {
          indexOnScreen = 0;
          controller.animateTo(0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear);
        });
      },
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.2,
        child: widget.allenamento.isNotEmpty
            ? Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: esercizi.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => SizedBox(
                                // color: Colors.amber,
                                width: MediaQuery.of(context).size.width,
                                child:
                                    //* schermata che cambia
                                    Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      // color: Colors.red,
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      child: SingleChildScrollView(
                                        child: Text(
                                          esercizi[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 27,
                                              color: widget.isDarkMode
                                                  ? Palette.white
                                                  : Palette.black),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Palette.primaryColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2),
                                      // color: Colors.red.withOpacity(0.2),
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: TextField(
                                        expands: true,
                                        style: TextStyle(
                                            color: widget.isDarkMode
                                                ? Palette.white
                                                : Palette.black),
                                        decoration: InputDecoration(
                                            labelText: 'Note Esercizio:',
                                            labelStyle: TextStyle(
                                                color: widget.isDarkMode
                                                    ? Palette.white.shade400
                                                    : Palette.black.shade700),
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: widget.isDarkMode
                                                ? Palette.primaryColor.shade50
                                                : Palette
                                                    .primaryColor.shade100),
                                        controller: controllerNote[index],
                                        maxLines: null,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                    ),
                  ),
                  //* icona per tornare indietro con gli esercizi
                  Positioned(
                    left: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: indexOnScreen > 0
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (indexOnScreen > 0) {
                                    indexOnScreen -= 1;
                                    controller.animateTo(
                                        indexOnScreen *
                                            MediaQuery.of(context).size.width,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut);
                                  }
                                });
                              },
                              child: const Icon(
                                Ionicons.chevron_back,
                                size: 50,
                                color: Palette.primaryColor,
                              ),
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ),
                  ),
                  //* timerBtn
                  Positioned(
                      top: MediaQuery.of(context).size.height / 10,
                      left: MediaQuery.of(context).size.width / 2 -
                          MediaQuery.of(context).size.width / 4 -
                          15,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height * 0.065,
                            decoration: BoxDecoration(
                                color: Palette.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() {
                                    timer > 15 ? timer -= 15 : null;
                                  }),
                                  child: Icon(
                                    Ionicons.remove,
                                    size: 25,
                                    color: widget.isDarkMode
                                        ? Palette.black
                                        : Palette.white,
                                  ),
                                ),
                                //* testo timer
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: Center(
                                    child: Text(_getTimerText(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: widget.isDarkMode
                                                ? Palette.black
                                                : Palette.white)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    timer < 600 ? timer += 15 : null;
                                  }),
                                  child: Icon(Ionicons.add,
                                      size: 25,
                                      color: widget.isDarkMode
                                          ? Palette.black
                                          : Palette.white),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => TimerPage(
                                                isDarkMode: widget.isDarkMode,
                                                esercizio:
                                                    esercizi[indexOnScreen],
                                                time: timer,
                                              ))),
                                  child: Icon(Ionicons.play,
                                      size: 25,
                                      color: widget.isDarkMode
                                          ? Palette.black
                                          : Palette.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),

                  //* icona per andare avanti con gli esercizi
                  Positioned(
                    right: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: indexOnScreen < esercizi.length - 1
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (indexOnScreen < esercizi.length - 1) {
                                    indexOnScreen += 1;
                                    controller.animateTo(
                                        indexOnScreen *
                                            MediaQuery.of(context).size.width,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut);
                                  }
                                });
                              },
                              child: const Icon(
                                Ionicons.chevron_forward,
                                color: Palette.primaryColor,
                                size: 50,
                              ),
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                'Carica una scheda',
                // 'Carica una scheda o un esercizio',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 1 / 23,
                    color: widget.isDarkMode ? Palette.white : Palette.black),
              )),
      ),
    );
  }

  // void saveCarichi() async {
  //   Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  //   String appDocumentsPath = appDocumentsDirectory.path;
  //   String filePath = '$appDocumentsPath/${esercizi[indexOnScreen]}.txt';
  //   File file = File(filePath);
  //   String saveableContent = '';
  // }

  String _getTimerText() {
    String temp = '';
    if (timer < 60) {
      temp = '00:$timer';
    } else {
      int min = timer ~/ 60;
      int sec = timer % 60;
      if (sec < 10) {
        min < 10 ? temp = '0$min:0$sec' : temp = '$min:0$sec';
      } else {
        min < 10 ? temp = '0$min:$sec' : temp = '$min:$sec';
      }
    }
    return temp;
  }
}
