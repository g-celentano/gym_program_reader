import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../palette.dart';
import '../../models/gym_program.dart';
import '../../view_models/main_scree_view_model.dart';

class ProgramSelector extends StatefulWidget {
  const ProgramSelector({super.key, required this.isDarkMode});
  final bool isDarkMode;

  @override
  State<ProgramSelector> createState() => _ProgramSelectorState();
}

class _ProgramSelectorState extends State<ProgramSelector> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<GymProgram> allPrograms =
        Provider.of<MainScreenViewModel>(context).programs;
    int selectedProgram =
        Provider.of<MainScreenViewModel>(context).selectedProgram;

    return Container(
        width: width,
        height: height * 0.125,
        color: Palette().getTenPercent(widget.isDarkMode),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility.maintain(
              visible: selectedProgram != 0,
              child: IconButton(
                icon: Icon(
                  Icons.chevron_left_rounded,
                  size: 36,
                  color: Palette().getSixtyPercent(widget.isDarkMode),
                ),
                onPressed: () {
                  if (selectedProgram > 0) {
                    Provider.of<MainScreenViewModel>(context, listen: false)
                        .setSelectedProgram(selectedProgram - 1);
                    Provider.of<MainScreenViewModel>(context, listen: false)
                        .setExerciseSelection(0);
                  }
                },
              ),
            ),
            Text(
              allPrograms[selectedProgram].day ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 36,
                color: Palette().getSixtyPercent(widget.isDarkMode),
              ),
            ),
            Visibility.maintain(
              visible: selectedProgram != allPrograms.length - 1,
              child: IconButton(
                icon: Icon(
                  Icons.chevron_right_rounded,
                  size: 36,
                  color: Palette().getSixtyPercent(widget.isDarkMode),
                ),
                onPressed: () {
                  if (selectedProgram < allPrograms.length - 1) {
                    Provider.of<MainScreenViewModel>(context, listen: false)
                        .setSelectedProgram(selectedProgram + 1);
                    Provider.of<MainScreenViewModel>(context, listen: false)
                        .setExerciseSelection(0);
                  }
                },
              ),
            ),
          ],
        ));
  }
}
