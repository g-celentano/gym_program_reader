import 'dart:async';

import 'package:alario_trainer_2/palette.dart';
import 'package:flutter/material.dart';
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
  String timerText = '';
  ValueNotifier<int> timer = ValueNotifier(0);
  late Timer t;

  @override
  void initState() {
    timer.value = widget.time;
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
                child: Text(
                  timerText,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.35,
                      color: widget.isDarkMode ? Palette.white : Palette.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
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
    t = Timer.periodic(const Duration(seconds: 1), (t) {
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
    });
  }
}
