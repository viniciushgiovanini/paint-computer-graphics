import 'package:flutter/material.dart';

// Widget: geracao de botões em cascata
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
        if (value == "Translacao") {
          updateMode("Translacao");
        } else if (value == "Rotacao") {
          updateMode("Rotacao");
        } else if (value == "Escala") {
          updateMode("Escala");
        } else if (value == "Reflexao") {
          updateMode("Reflexao");
        }
      });
}
