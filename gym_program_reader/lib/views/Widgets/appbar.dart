import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gym_program_reader/view_models/main_scree_view_model.dart';
import 'package:gym_program_reader/palette.dart';
import 'package:provider/provider.dart';

class AppBarContent extends StatefulWidget {
  const AppBarContent({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<AppBarContent> createState() => _AppBarContentState();
}

class _AppBarContentState extends State<AppBarContent> {
  @override
  Widget build(BuildContext context) {
    int programCount = Provider.of<MainScreenViewModel>(context).programsCount;

    return Container(
      color: Palette().getSixtyPercent(widget.isDarkMode),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'Gym Program Reader',
                  style: TextStyle(
                    color: Palette().getTenPercent(widget.isDarkMode),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                programCount == 0
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 24,
                          color: Palette().getTenPercent(widget.isDarkMode),
                        ),
                        onPressed: () async {
                          await loadProgram(false);
                        },
                      )
                    : IconButton(
                        onPressed: () async {
                          await loadProgram(true);
                        },
                        icon: Icon(
                          Icons.change_circle_rounded,
                          size: 24,
                          color: Palette().getTenPercent(widget.isDarkMode),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadProgram(bool isChanging) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      if (context.mounted) {
        if (isChanging) {
          Provider.of<MainScreenViewModel>(context, listen: false)
              .setLoadedPrograms(null);
          Provider.of<MainScreenViewModel>(context, listen: false)
              .fetchPrograms(result.files.single.path!, false);
        } else {
          Provider.of<MainScreenViewModel>(context, listen: false)
              .fetchPrograms(result.files.single.path!, false);
        }
      }
    } else {
      // User canceled the picker
    }
  }
}
