import 'package:flutter/material.dart';

// Imports meu
// import '../algorithms/dda.dart';

Widget getPopUpMenuButtom(
  List<PopupMenuItem<String>> listadePopUp,
  void Function(String) updateMode,
) {
  List<PopupMenuEntry<String>> items = [];

  listadePopUp.forEach((PopupMenuItem item) {
    items.add(PopupMenuItem<String>(
      value: item.value.toString(),
      child: item.child,
    ));
  });

  return PopupMenuButton<String>(
      icon: Icon(Icons.code),
      itemBuilder: (BuildContext context) => items,
      onSelected: (String value) {
        if (value == "DDA") {
          updateMode("DDA");
        }
      });
}
