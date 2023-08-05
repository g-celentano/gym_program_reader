import 'package:flutter/material.dart';
import 'package:gym_program_reader/models/gym_program_repository.dart';
import 'package:gym_program_reader/models/gym_program.dart';

class MainScreenViewModel with ChangeNotifier {
  List<GymProgram> _programs = List.empty(growable: true);
  int _selectedProgam = 0;
  List<ExerciseNotes> _notes = List.empty(growable: true);
  int _selectedExerise = 0;
  String error = "";

  get programs {
    return _programs;
  }

  get programsCount {
    return _programs.length;
  }

  get selectedProgram {
    return _selectedProgam;
  }

  get notes {
    return _notes;
  }

  get selectedExercise {
    return _selectedExerise;
  }

  Future<void> saveNotes(GymProgram selected, ExerciseNotes notes) async {
    try {
      await GymProgramRepository().saveProgramNotes(selected, notes);
    } catch (e) {
      error = e.toString();
    }
  }

  Future<void> fetchPrograms(String path, bool isFromLocalStorage) async {
    try {
      List<GymProgram> loaded =
          await GymProgramRepository().fetchPrograms(path, isFromLocalStorage);
      setLoadedPrograms(loaded);
      setSelectedProgram(0);
      setExerciseSelection(0);
      // List<ExerciseNotes> loadedNotes =
      //     await GymProgramRepository().getProgramNotes(loaded[0]);
      // setNotes(loadedNotes);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      //print(e);
    }
    notifyListeners();
  }

  void setLoadedPrograms(List<GymProgram>? programs) {
    if (programs != null) {
      _programs = programs;
      notifyListeners();
    } else {
      _programs = [];
      notifyListeners();
    }
  }

  void setSelectedProgram(int? selected) {
    if (selected != null) {
      _selectedProgam = selected;
      notifyListeners();
    }
  }

  void setNotes(List<ExerciseNotes>? notes) {
    if (notes != null) {
      _notes = notes;
      notifyListeners();
    }
  }

  void setExerciseSelection(int? ex) {
    if (ex != null) {
      _selectedExerise = ex;
      notifyListeners();
    }
  }
}
