import 'dart:convert';
import 'dart:io';
import 'gym_program.dart';
import 'package:path_provider/path_provider.dart';

typedef ExerciseNotes = Map<String, String>;

class GymProgramRepository {
  Future<List<GymProgram>> fetchPrograms(
      String path, bool isfromLocalStorage) async {
    dynamic response = File(path);
    List<GymProgram> programs = await readPrograms(response);
    if (!isfromLocalStorage) {
      await saveFile(programs);
    }
    return programs;
  }

  Future<List<GymProgram>> readPrograms(File file) async {
    List<GymProgram> programs = List.empty(growable: true);
    List<String> separators = ["GIORNO", "DAY", "PROGRAM"];
    List<String> content = await file.readAsLines(encoding: latin1);
    List<String> days = content
        .where((element) =>
            separators.contains(element.toUpperCase().split(' ').first))
        .toList();
    List<List<String>> workouts = List.empty(growable: true);

    for (int i = 0; i < days.length; i++) {
      if (i != days.length - 1) {
        workouts.add(content.sublist(
            content.indexOf(days[i]), content.indexOf(days[i + 1])));
      } else {
        workouts.add(content.sublist(content.indexOf(days[i])));
      }
      workouts[i].removeWhere(
          (el) => el == days[i] || el.isEmpty || el.contains("------"));
      programs.add(GymProgram.setProgram(days[i], workouts[i]));
    }

    return programs;
  }

  Future<bool> saveFile(List<GymProgram> content) async {
    bool isSaved = false;
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/schedaSalvata.txt';
    File file = File(filePath);
    String saveableContent = '';
    for (GymProgram element in content) {
      saveableContent += '${element.toString()}\n';
    }
    file.writeAsString(saveableContent).then((value) => isSaved = true);
    return isSaved;
  }

  Future<List<ExerciseNotes>> getProgramNotes(GymProgram selected) async {
    List<ExerciseNotes> notes = List.empty(growable: true);
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String? selectedName = selected.day?.replaceAll(' ', '');
    for (String ex in selected.exercises ?? []) {
      int spacePosition = ex.indexOf(' ');
      String addable = ex.substring(spacePosition);
      addable = addable.replaceAll(' ', '_');
      String filePath =
          '$appDocumentsPath/${selectedName ?? ""}-${addable.trim()}.txt';
      File file = File(filePath);
      notes.add({ex: await file.readAsString(encoding: latin1)});
    }

    return notes;
  }

  Future<void> saveProgramNotes(
      GymProgram selected, ExerciseNotes notes) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String? selectedName = selected.day?.replaceAll(' ', '');
    int spacePosition = notes.keys.first.indexOf(' ');
    String addable = notes.keys.first.substring(spacePosition);
    addable = addable.replaceAll(' ', '_');
    String filePath =
        '$appDocumentsPath/${selectedName ?? ""}-${addable.trim()}.txt';
    File file = File(filePath);
    await file.writeAsString(notes.values.first);
  }
}
