import 'package:flutter/material.dart';

class OrganizzaScheda extends StatefulWidget {
  const OrganizzaScheda({
    Key? key,
    required this.giorni,
  }) : super(key: key);

  final List<String> giorni;

  @override
  State<OrganizzaScheda> createState() => _OrganizzaSchedaState();
}

class _OrganizzaSchedaState extends State<OrganizzaScheda> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.giorni.length,
        itemBuilder: ((context, index) => Card(
              child: widget.giorni[index].isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.giorni[index].trim()),
                    )
                  : null,
            )),
      ),
    );
  }
}
