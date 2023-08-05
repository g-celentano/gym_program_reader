import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_program_reader/models/gym_program.dart';
import 'package:gym_program_reader/palette.dart';
import 'package:gym_program_reader/view_models/main_scree_view_model.dart';
import 'package:gym_program_reader/views/Widgets/custom_clipper.dart';
import 'package:gym_program_reader/views/Widgets/timer_setter.dart';
import 'package:provider/provider.dart';

class TimerView extends StatefulWidget {
  const TimerView({
    super.key,
    required this.isDarkMode,
    required this.seconds,
  });

  final bool isDarkMode;
  final int seconds;

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  late int _start;
  int _startedTimers = 0;

  @override
  void initState() {
    _controller = AnimationController(
      value: 0.0,
      upperBound: 1,
      lowerBound: 0.0,
      duration: Duration(seconds: widget.seconds),
      vsync: this,
    )..forward();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    setState(() {
      _startedTimers += 1;
      _start = widget.seconds;
    });
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          // setState(() {
          //   timer.cancel();
          // });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void restartTimer() {
    setState(() {
      _startedTimers += 1;
      _start = widget.seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int program = Provider.of<MainScreenViewModel>(context).selectedProgram;
    List<GymProgram> allPrograms =
        Provider.of<MainScreenViewModel>(context).programs;
    int selectedEx = Provider.of<MainScreenViewModel>(context).selectedExercise;
    int spacePosition =
        allPrograms[program].exercises![selectedEx].indexOf(' ');
    String exName =
        allPrograms[program].exercises![selectedEx].substring(spacePosition);
    String series =
        allPrograms[program].exercises![selectedEx].substring(0, spacePosition);

    return Scaffold(
      backgroundColor: Palette().getSixtyPercent(widget.isDarkMode),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.0125),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: width * 0.25,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chevron_left,
                              size: 16,
                              color: Palette().getTenPercent(widget.isDarkMode),
                            ),
                            Text(
                              "Back",
                              style: TextStyle(
                                color:
                                    Palette().getTenPercent(widget.isDarkMode),
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: width * 0.075),
              child: Text(
                _start.getTimeString(),
                style: TextStyle(
                  color: Palette().getThirtyPercent(widget.isDarkMode),
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: width * 0.9,
              height: width * 0.9,
              child: _start != 0
                  ? Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette().getTenPercent(widget.isDarkMode),
                        ),
                        width: width * 0.85,
                        height: width * 0.85,
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return ClipPath(
                            clipper: TimerCustomClipper(
                                clipAmount: _controller.value),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Palette()
                                    .getSixtyPercent(widget.isDarkMode),
                              ),
                              width: width * 0.85,
                              height: width * 0.85,
                            ),
                          );
                        },
                      ),
                    ])
                  : Padding(
                      padding: EdgeInsets.all(width * 0.2125),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => getColor(states,
                                  Palette().getTenPercent(widget.isDarkMode))),
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                        ),
                        onPressed: () {
                          _controller.reset();
                          _controller.forward();

                          restartTimer();
                        },
                        child: Icon(
                          Icons.restart_alt_rounded,
                          size: width * 0.3,
                          color: Palette().getSixtyPercent(widget.isDarkMode),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(top: width * 0.15),
              child: Column(
                children: [
                  Text(
                    exName,
                    style: TextStyle(
                      color: Palette().getThirtyPercent(widget.isDarkMode),
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    series,
                    style: TextStyle(
                      color: Palette().getThirtyPercent(widget.isDarkMode),
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Started Timers: $_startedTimers",
                    style: TextStyle(
                      color: Palette().getThirtyPercent(widget.isDarkMode),
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states, Color color) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return color.withOpacity(0.75);
    }
    return color;
  }
}
