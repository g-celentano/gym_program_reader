import 'package:alario_trainer_2/palette.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class OrganizzaScehda extends StatefulWidget {
  const OrganizzaScehda({
    Key? key,
    required this.allenamento,
    required this.isDarkMode,
  }) : super(key: key);

  final List<String> allenamento;
  final bool isDarkMode;

  @override
  State<OrganizzaScehda> createState() => OrganizzaScehdaState();
}

class OrganizzaScehdaState extends State<OrganizzaScehda> {
  List<String> esercizi = List.empty(growable: true);
  ScrollController controller = ScrollController();
  int indexOnScreen = 0;

  @override
  Widget build(BuildContext context) {
    esercizi = widget.allenamento
        .where((element) =>
            element.isNotEmpty && !element.toUpperCase().contains('GIORNO'))
        .toList();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.2,
      child: widget.allenamento.isNotEmpty
          ? Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.2,
                    // height: double.infinity,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: esercizi.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Text(
                                    esercizi[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: widget.isDarkMode
                                            ? Palette.white
                                            : Palette.black),
                                  ),
                                ],
                              ),
                            )),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: indexOnScreen > 0
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                if (indexOnScreen > 0) {
                                  indexOnScreen -= 1;
                                  controller.animateTo(
                                      indexOnScreen *
                                          MediaQuery.of(context).size.width,
                                      duration:
                                          const Duration(milliseconds: 150),
                                      curve: Curves.easeIn);
                                }
                              });
                            },
                            child: Icon(
                              Ionicons.chevron_back,
                              size: 50,
                              color: widget.isDarkMode
                                  ? Palette.primaryColor
                                  : Palette.black,
                            ),
                          )
                        : const SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: indexOnScreen < esercizi.length - 1
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                if (indexOnScreen < esercizi.length - 1) {
                                  indexOnScreen += 1;
                                  controller.animateTo(
                                      indexOnScreen *
                                          MediaQuery.of(context).size.width,
                                      duration:
                                          const Duration(milliseconds: 150),
                                      curve: Curves.easeIn);
                                }
                              });
                            },
                            child: Icon(
                              Ionicons.chevron_forward,
                              color: widget.isDarkMode
                                  ? Palette.primaryColor
                                  : Palette.black,
                              size: 50,
                            ),
                          )
                        : const SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
              'Carica una scheda o un esercizio',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 1 / 23,
                  color: widget.isDarkMode ? Palette.white : Palette.black),
            )),
    );
  }
}
