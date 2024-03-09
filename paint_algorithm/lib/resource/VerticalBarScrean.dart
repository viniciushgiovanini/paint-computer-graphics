import 'package:flutter/material.dart';

// Imports meus
import 'GetIcon.dart';
import "PopupMenuButton.dart";

class VerticalBarScreen extends StatefulWidget {
  final List<Offset> points;
  final Function(List<Offset>) updatePoints;

  VerticalBarScreen(
      {super.key, required this.points, required this.updatePoints});

  @override
  State<VerticalBarScreen> createState() => _VerticalBarScreenState();
}

class _VerticalBarScreenState extends State<VerticalBarScreen> {
  // Função para atualizar os pontos e chamar setState

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Color.fromARGB(255, 103, 233, 125),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getIcon(Icons.delete, 35.0, () {
            widget.points.clear();
          }),
          getPopUpMenuButtom([
            PopupMenuItem(value: "DDA", child: Text("DDA")),
            PopupMenuItem(value: "Bresenham", child: Text("Bresenham"))
          ], widget.points, widget.updatePoints)
        ],
      ),
    );
  }
}
