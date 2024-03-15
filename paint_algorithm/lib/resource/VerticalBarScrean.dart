import 'package:flutter/material.dart';
import 'package:paint_algorithm/class/Points.dart';

// Imports meus
import 'GetIcon.dart';
import "PopupMenuButton.dart";
import 'GetDialog.dart';

// Algs imports
import '../algorithms/rotacao.dart';
import '../class/Object.dart';

class VerticalBarScreen extends StatefulWidget {
  final List<Points> points_class;
  final List<Object> lista_objetos;
  final Function(String) updateMode;
  final Function(String) updateModeAlgoritmo;
  final Function(List<Object>) attListaObject;
  final String mode_text;

  VerticalBarScreen(
      {super.key,
      required this.mode_text,
      required this.attListaObject,
      required this.lista_objetos,
      required this.points_class,
      required this.updateMode,
      required this.updateModeAlgoritmo});

  @override
  State<VerticalBarScreen> createState() => _VerticalBarScreenState();
}

class _VerticalBarScreenState extends State<VerticalBarScreen> {
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
              widget.updateModeAlgoritmo,
            );
          }),
          getIcon(Icons.brush, 35.0, () {
            widget.updateMode("Painter");
          }),
          getIcon(Icons.straight, 35.0, () {
            widget.updateMode("Reta");
          }),
          getIcon(Icons.timeline, 35.0, () {
            widget.updateMode("Poligono");
          }),
          getIcon(Icons.circle_outlined, 35.0, () {
            widget.updateMode("Circunferencia");
          }),
          getPopUpMenuButtom([
            PopupMenuItem(value: "Translacao", child: Text("Translacao")),
            PopupMenuItem(value: "Rotacao", child: Text("Rotacao")),
            PopupMenuItem(value: "Escala", child: Text("Escala")),
            PopupMenuItem(value: "Reflexao", child: Text("Reflexao")),
          ], widget.updateMode, Icons.screen_rotation_alt),
          Container(
            width: 70,
            height: 40,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelText: "Ang",
                  hintText: '90.0',
                  border: OutlineInputBorder()),
              onSubmitted: (value) {
                try {
                  widget.attListaObject(initAlgoritms(widget.mode_text,
                      widget.lista_objetos, double.parse(value)));
                } catch (w) {
                  // widget.updateAngle(0.0);
                  "".toString();
                  print("DEU RUIM");
                }
              },
            ),
          ),
          getIcon(Icons.delete, 35.0, () {
            widget.points_class.clear();
            widget.lista_objetos.clear();
          }),
        ],
      ),
    );
  }
}

List<Object> initAlgoritms(
    String mode_text, List<Object> lista_objetos, double angle) {
  Object last_obj = lista_objetos[lista_objetos.length - 1];

  if (mode_text == "Rotacao") {
    Object last_obj = lista_objetos[lista_objetos.length - 1];
    lista_objetos.removeAt(lista_objetos.length - 1);

    lista_objetos
        .add(rotacaoObject(last_obj, angle, last_obj.lista_de_pontos[0].ponto));
  }

  return lista_objetos;
}
