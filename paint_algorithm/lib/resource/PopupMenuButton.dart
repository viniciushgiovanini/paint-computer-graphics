import 'package:flutter/material.dart';

// Imports meu
// import '../algorithms/dda.dart';

Widget getPopUpMenuButtom(
  List<PopupMenuItem<String>> listadePopUp,
  void Function(String) updateMode,
  IconData icon_name,
) {
  List<PopupMenuEntry<String>> items = [];

  listadePopUp.forEach((PopupMenuItem item) {
    items.add(PopupMenuItem<String>(
      value: item.value.toString(),
      child: item.child,
    ));
  });

  return PopupMenuButton<String>(
      icon: Icon(
        icon_name,
      ),
      iconSize: 35.0,
      itemBuilder: (BuildContext context) => items,
      onSelected: (String value) {
        if (value == "DDA") {
          updateMode("DDA");
        } else if (value == "Bresenham-Reta") {
          updateMode("Bresenham-Reta");
        } else if (value == "Bresenham-Circ") {
          updateMode("Bresenham-Circ");
        }
      });
}
