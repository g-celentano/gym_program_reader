import 'package:flutter/material.dart';
import 'package:gym_program_reader/palette.dart';
import 'package:gym_program_reader/views/timer_view.dart';

class TimeSetter extends StatefulWidget {
  const TimeSetter({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;

  @override
  State<TimeSetter> createState() => _TimeSetterState();
}

extension ToTime on int {
  String getTimeString() {
    int minutes = this ~/ 60;
    int secs = this % 60;

    return "${minutes < 10 ? "0$minutes" : minutes}:${secs < 10 ? "0$secs" : secs}";
  }
}

class _TimeSetterState extends State<TimeSetter> {
  int seconds = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: width * 0.75,
            height: width * 0.125,
            decoration: BoxDecoration(
                color: Palette().getSixtyPercent(widget.isDarkMode),
                borderRadius: BorderRadius.circular(6),
                border: Border(
                  top: BorderSide(
                      color: Palette().getThirtyPercent(widget.isDarkMode)),
                  left: BorderSide(
                      color: Palette().getThirtyPercent(widget.isDarkMode)),
                  right: BorderSide(
                      color: Palette().getThirtyPercent(widget.isDarkMode)),
                  bottom: BorderSide(
                      color: Palette().getThirtyPercent(widget.isDarkMode)),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      seconds -= seconds > 0 ? 15 : 0;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) =>
                        getColor(states,
                            Palette().getTenPercent(widget.isDarkMode))),
                    foregroundColor: MaterialStateColor.resolveWith((states) =>
                        getColor(states,
                            Palette().getSixtyPercent(widget.isDarkMode))),
                    fixedSize: MaterialStateProperty.all(
                        Size(width * 0.2, width * 0.125)),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(5)))),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 24,
                    color: Palette().getSixtyPercent(widget.isDarkMode),
                  ),
                ),
                const Spacer(),
                Text(
                  seconds.getTimeString(),
                  style: TextStyle(
                    color: Palette().getThirtyPercent(widget.isDarkMode),
                    fontWeight: FontWeight.normal,
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      seconds += seconds < 600 ? 15 : 0;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) =>
                        getColor(states,
                            Palette().getTenPercent(widget.isDarkMode))),
                    foregroundColor: MaterialStateColor.resolveWith((states) =>
                        getColor(states,
                            Palette().getSixtyPercent(widget.isDarkMode))),
                    fixedSize: MaterialStateProperty.all(
                        Size(width * 0.2, width * 0.125)),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(5)))),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: Palette().getSixtyPercent(widget.isDarkMode),
                  ),
                )
              ],
            )),
        Padding(
          padding: EdgeInsets.only(top: width * 0.075),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TimerView(
                    isDarkMode: widget.isDarkMode,
                    seconds: seconds,
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) =>
                  getColor(
                      states, Palette().getThirtyPercent(widget.isDarkMode))),
              foregroundColor: MaterialStateColor.resolveWith((states) =>
                  getColor(
                      states, Palette().getSixtyPercent(widget.isDarkMode))),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: width * 0.025, horizontal: width * 0.05),
              child: Text(
                "Start Timer",
                style: TextStyle(
                  color: Palette().getSixtyPercent(widget.isDarkMode),
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
      ],
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
