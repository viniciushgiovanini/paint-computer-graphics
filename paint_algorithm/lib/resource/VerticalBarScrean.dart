import 'package:flutter/material.dart';
import 'package:paint_algorithm/class/Points.dart';

// Imports meus
import 'GetIcon.dart';
// import "PopupMenuButton.dart";
import 'GetDialog.dart';

class VerticalBarScreen extends StatefulWidget {
  final List<Points> points_class;
  final Function(String) updateMode;
  final Function(int) updatePixelId;

  VerticalBarScreen(
      {super.key,
      required this.points_class,
      required this.updateMode,
      required this.updatePixelId});

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
          getIcon(Icons.settings, 35.0, () {
            getDialog(
              context,
            );
          }),
          getIcon(Icons.delete, 35.0, () {
            widget.points_class.clear();
            widget.updatePixelId(0);
          }),
          getIcon(Icons.brush, 35.0, () {
            widget.updateMode("Painter");
          }),
          getIcon(Icons.straight, 35.0, () {
            widget.updateMode("Reta");
          }),
        ],
      ),
    );
  }
}
