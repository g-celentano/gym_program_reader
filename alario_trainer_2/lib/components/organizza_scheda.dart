import 'package:flutter/material.dart';

class OrganizzaScheda extends StatefulWidget {
  const OrganizzaScheda({
    Key? key,
    required this.scheda,
  }) : super(key: key);

  final String scheda;

  @override
  State<OrganizzaScheda> createState() => _OrganizzaSchedaState();
}

class _OrganizzaSchedaState extends State<OrganizzaScheda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 500,
      color: Colors.amber,
      child: Text(widget.scheda),
    );
  }
}
