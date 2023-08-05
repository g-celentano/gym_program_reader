import 'package:flutter/material.dart';
import 'package:gym_program_reader/models/gym_program.dart';
import 'package:gym_program_reader/view_models/main_scree_view_model.dart';
import 'package:gym_program_reader/palette.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  const Notes({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int selected = Provider.of<MainScreenViewModel>(context).selectedProgram;
    List<GymProgram> allPrograms =
        Provider.of<MainScreenViewModel>(context).programs;
    int selectedEx = Provider.of<MainScreenViewModel>(context).selectedExercise;

    return SizedBox(
      width: width * 0.9,
      height: width * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.01),
            child: Text(
              "Notes",
              style: TextStyle(
                color: Palette().getThirtyPercent(widget.isDarkMode),
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            width: width * 0.9,
            height: width * 0.375,
            decoration: BoxDecoration(
                color: Palette().getSixtyPercent(widget.isDarkMode),
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  top: BorderSide(
                      color: Palette().getTenPercent(widget.isDarkMode)),
                  left: BorderSide(
                      color: Palette().getTenPercent(widget.isDarkMode)),
                  right: BorderSide(
                      color: Palette().getTenPercent(widget.isDarkMode)),
                  bottom: BorderSide(
                      color: Palette().getTenPercent(widget.isDarkMode)),
                )),
            child: Padding(
              padding: EdgeInsets.all(width * 0.01),
              child: TextField(
                controller: noteController,
                maxLines: null,
                style: TextStyle(
                  color: Palette().getThirtyPercent(widget.isDarkMode),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
                // onChanged: (value) {
                //   var slctd = allPrograms[selected];
                //   if (slctd.exercises != null) {
                //     Provider.of<MainScreenViewModel>(context, listen: false)
                //         .saveNotes(
                //             slctd, {slctd.exercises![selectedEx]: value});
                //   }
                // },
                onSubmitted: (value) {
                  var slctd = allPrograms[selected];
                  if (slctd.exercises != null) {
                    Provider.of<MainScreenViewModel>(context, listen: false)
                        .saveNotes(
                            slctd, {slctd.exercises![selectedEx]: value});
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
