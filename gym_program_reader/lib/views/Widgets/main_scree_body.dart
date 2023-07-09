import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:gym_program_reader/models/gym_program.dart';
// import 'package:gym_program_reader/main_screen/view/Widgets/notes.dart';
import 'package:gym_program_reader/views/Widgets/program_selector.dart';
import 'package:gym_program_reader/views/Widgets/timer_setter.dart';
import 'package:gym_program_reader/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../view_models/main_scree_view_model.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<HomeScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String appDocumentsPath = appDocumentsDirectory.path;
      String filePath = '$appDocumentsPath/schedaSalvata.txt';
      if (context.mounted) {
        Provider.of<MainScreenViewModel>(context, listen: false)
            .fetchPrograms(filePath, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<GymProgram> allPrograms =
        Provider.of<MainScreenViewModel>(context).programs;
    int selectedProgram =
        Provider.of<MainScreenViewModel>(context).selectedProgram;
    int dropdownValue =
        Provider.of<MainScreenViewModel>(context).selectedExercise;

    return allPrograms.isEmpty
        ? Center(
            child: Text(
              "Add Your Program",
              style: TextStyle(
                color: Palette().getTenPercent(widget.isDarkMode),
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, width * 0.025, 0, 0),
                child: TextButton(
                  onPressed: () {
                    showPickerDialog(context, allPrograms[selectedProgram]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Choose Exercise",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Palette().getThirtyPercent(widget.isDarkMode),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 26,
                        color: Palette().getThirtyPercent(widget.isDarkMode),
                      ),
                    ],
                  ),
                ),
              ),
              allPrograms[selectedProgram].exercises != null
                  ? Padding(
                      padding: EdgeInsets.all(width * 0.1),
                      child: SizedBox(
                        width: width * 0.9,
                        height: width * 0.3,
                        child: Text(
                          allPrograms[selectedProgram]
                              .exercises![dropdownValue],
                          style: TextStyle(
                            color:
                                Palette().getThirtyPercent(widget.isDarkMode),
                            fontWeight: FontWeight.normal,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
              Padding(
                padding: EdgeInsets.only(top: width * 0.0),
                child: TimeSetter(isDarkMode: widget.isDarkMode),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: width * 0.1),
              //   child: Notes(isDarkMode: widget.isDarkMode),
              // ),
              const Spacer(),
              ProgramSelector(isDarkMode: widget.isDarkMode)
            ],
          );
  }

  showPickerDialog(BuildContext context, GymProgram selected) {
    return Picker(
        adapter: PickerDataAdapter<String>(
            pickerData: const JsonDecoder().convert(selected.adaptForPicker())),
        hideHeader: true,
        title: Text(
          "Choose Exercise",
          style: TextStyle(
            color: Palette().getTenPercent(widget.isDarkMode),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        selectionOverlay: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: Palette().getTenPercent(widget.isDarkMode).withOpacity(0.15),
          ),
        ),
        cancelTextStyle: TextStyle(
          color: Palette().getTenPercent(widget.isDarkMode),
          fontSize: 20,
        ),
        confirmTextStyle: TextStyle(
          color: Palette().getTenPercent(widget.isDarkMode),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textStyle: TextStyle(
          color: Palette().getThirtyPercent(widget.isDarkMode),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Palette().getSixtyPercent(widget.isDarkMode),
        onConfirm: (Picker picker, List value) {
          setState(() {
            Provider.of<MainScreenViewModel>(context, listen: false)
                .setExerciseSelection(value.first);
          });
          //print(value.toString());
          //print(picker.getSelectedValues());
        }).showDialog(
      context,
      backgroundColor: Palette().getSixtyPercent(widget.isDarkMode),
    );
  }
}
