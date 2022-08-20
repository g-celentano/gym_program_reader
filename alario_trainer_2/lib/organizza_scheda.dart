import 'package:flutter/material.dart';

class OrganizzaScehda extends StatefulWidget {
  const OrganizzaScehda({
    Key? key,
    required this.content,
    required this.isDarkMode,
  }) : super(key: key);

  final List<String> content;
  final bool isDarkMode;

  @override
  State<OrganizzaScehda> createState() => OrganizzaScehdaState();
}

class OrganizzaScehdaState extends State<OrganizzaScehda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.amber,
    );
  }
}
