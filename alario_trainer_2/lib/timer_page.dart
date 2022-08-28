import 'dart:async';

import 'package:alario_trainer_2/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({
    Key? key,
    required this.isDarkMode,
    required this.esercizio,
    required this.time,
  }) : super(key: key);
  final bool isDarkMode;
  final String esercizio;
  final int time;

  @override
  State<TimerPage> createState() => TimerState();
}

class TimerState extends State<TimerPage> {
  bool timerStarted = false;
  bool blinking = false;
  bool optionsVisible = false;
  int numTimer = 1;
  String timerText = '';
  ValueNotifier<int> timer = ValueNotifier(0);
  late Timer t;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.25,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
                t.cancel();
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Ionicons.chevron_back,
                  color: widget.isDarkMode ? Palette.black : Palette.white,
                ),
              ),
            ),
            widget.isDarkMode
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/imgs/LogoDarkMode.png"),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/imgs/LogoLightMode.png"),
                  ),
          ],
        ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            color: Colors.transparent,
            child: Center(
              child: Text(
                widget.esercizio.substring(
                  widget.esercizio.indexOf(' '),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    // backgroundColor: Colors.amber,
                    color: widget.isDarkMode ? Palette.black : Palette.white,
                    fontSize: 24),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: widget.isDarkMode ? Palette.black.shade600 : Palette.white,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(seconds: widget.time),
              top: timerStarted ? MediaQuery.of(context).size.height * 0.95 : 0,
              child: Container(
                color: Palette.primaryColor,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: !blinking,
                  child: Text(
                    timerText,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.35,
                        color:
                            widget.isDarkMode ? Palette.white : Palette.black),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.15),
                  child: SizedBox(
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Timer Avviati: $numTimer - Serie: ${widget.esercizio.substring(0, widget.esercizio.toUpperCase().indexOf('X'))} ',
                          style: TextStyle(
                              color: widget.isDarkMode
                                  ? Palette.white
                                  : Palette.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07),
                        ),
                        Visibility(
                          visible: optionsVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      t.cancel();
                                      blinking = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12)),
                                  child: Icon(
                                    Ionicons.stop_circle_outline,
                                    size: 40,
                                    color: widget.isDarkMode
                                        ? Palette.black
                                        : Palette.white,
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (numTimer <
                                          int.parse(widget.esercizio.substring(
                                              0,
                                              widget.esercizio
                                                  .toUpperCase()
                                                  .indexOf('X')))) {
                                        timerStarted = false;
                                        numTimer++;
                                        t.cancel();
                                        blinking = false;
                                        optionsVisible = false;
                                      }
                                    });
                                    startTimer();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12)),
                                  child: Icon(
                                    FeatherIcons.rotateCcw,
                                    size: 40,
                                    color: widget.isDarkMode
                                        ? Palette.black
                                        : Palette.white,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    timer.value = widget.time;
    setState(() {
      String temp = '';
      int min = timer.value ~/ 60;
      int sec = timer.value % 60;
      if (sec < 10) {
        min < 10 ? temp = '0$min:0$sec' : temp = '$min:0$sec';
      } else {
        min < 10 ? temp = '0$min:$sec' : temp = '$min:$sec';
      }
      timerText = temp;
    });
    timer.addListener(() {
      setState(() {
        timerStarted = true;
      });
    });
    t = Timer.periodic(const Duration(seconds: 1), (timerTimer) {
      String temp = '';
      timer.value > 0 ? timer.value -= 1 : null;
      int min = timer.value ~/ 60;
      int sec = timer.value % 60;
      if (sec < 10) {
        min < 10 ? temp = '0$min:0$sec' : temp = '$min:0$sec';
      } else {
        min < 10 ? temp = '0$min:$sec' : temp = '$min:$sec';
      }
      setState(() {
        timerText = temp;
      });
      if (timerText == '00:00') {
        t.cancel();
        optionsVisible = true;
        t = Timer.periodic(
            const Duration(milliseconds: 200),
            (timer) => setState(() {
                  blinking = !blinking;
                }));
      }
    });
  }
}
