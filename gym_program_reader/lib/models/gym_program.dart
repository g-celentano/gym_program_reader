class GymProgram {
  final String? day;
  final List<String>? exercises;

  GymProgram({this.day, this.exercises});

  factory GymProgram.setProgram(String day, List<String> exs) {
    return GymProgram(day: day, exercises: exs);
  }
  @override
  String toString() {
    if (day != null && exercises != null) {
      String stringified = "";
      stringified += '$day\n';
      for (String ex in exercises!) {
        stringified += '$ex\n';
      }
      return stringified;
    } else {
      return "";
    }
  }

  String adaptForPicker() {
    if (exercises != null) {
      String pickerContent = '[';
      for (String element in exercises!) {
        if (element.isNotEmpty) {
          int spacePosition = element.indexOf(' ');
          String addable = element.substring(spacePosition);
          pickerContent += '"${addable.trim()}",';
        }
      }
      pickerContent = pickerContent.substring(0, pickerContent.length - 1);
      pickerContent += ']';
      return pickerContent;
    } else {
      return "[]";
    }
  }
}
