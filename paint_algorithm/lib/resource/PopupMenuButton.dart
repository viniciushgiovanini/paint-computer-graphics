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

  // return PopupMenuButton<String>(
  //   icon: Icon(Icons.code),
  //   itemBuilder: (BuildContext context) => items,
  //   onSelected: (String value) {
  //     if (value == "DDA" && points.length != 0) {
  //       if (points.length == 2) {
  //         points = paintDDA(points);
  //         updatePoints(points, "DDA");
  //       } else {
  //         List<Offset> ultimosElementos = [];
  //         ultimosElementos.addAll(points.sublist(points.length - 2));
  //         points.removeRange(points.length - 2, points.length);

  //         ultimosElementos = paintDDA(ultimosElementos);
  //         points.addAll(ultimosElementos);
  //         updatePoints(points, "DDA");
  //       }
  //     }
  //   },
  // );
  return PopupMenuButton<String>(
      icon: Icon(Icons.code),
      itemBuilder: (BuildContext context) => items,
      onSelected: (String value) {
        if (value == "DDA") {
          updateMode("DDA");
        }
      });
}
