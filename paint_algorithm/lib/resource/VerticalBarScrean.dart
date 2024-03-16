import 'package:flutter/material.dart';

// Imports meus
import 'GetIcon.dart';
import "PopupMenuButton.dart";
import 'GetDialog.dart';

// Algs imports
import '../algorithms/transformacoes.dart';
import '../class/Object.dart';

class VerticalBarScreen extends StatefulWidget {
  final List<Offset> points_class;
  final List<Object> lista_objetos;
  final Function(String) updateMode;
  final Function(String) updateModeAlgoritmo;
  final Function(List<Object>) attListaObject;
  final String mode_text;
  final Function(String) updateModeRecorte;

  VerticalBarScreen(
      {super.key,
      required this.updateModeRecorte,
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
  FocusNode _focusNode = FocusNode();

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
              widget.updateModeRecorte,
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
          getIcon(Icons.cut, 35.0, () {
            widget.updateMode("Recorte");
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
              focusNode: _focusNode,
              decoration: InputDecoration(
                  labelText: "Input",
                  // hintText: '90.0',
                  border: OutlineInputBorder()),
              onSubmitted: (value) {
                widget.attListaObject(transformacoesGeometricas(
                  widget.mode_text,
                  widget.lista_objetos,
                  value,
                ));
                _focusNode.requestFocus();
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

List<Object> transformacoesGeometricas(
    String mode_text, List<Object> lista_objetos, String value) {
  // ignore: unused_local_variable
  Object last_obj = lista_objetos[lista_objetos.length - 1];

  if (mode_text == "Rotacao") {
    Object last_obj = lista_objetos[lista_objetos.length - 1];
    lista_objetos.removeAt(lista_objetos.length - 1);

    try {
      lista_objetos.add(rotacaoObject(last_obj, double.parse(value)));
    } catch (e) {
      print("Error: " + e.toString());
    }
    return lista_objetos;
  } else if (mode_text == "Escala") {
    Object last_obj = lista_objetos[lista_objetos.length - 1];
    lista_objetos.removeAt(lista_objetos.length - 1);

    try {
      last_obj.lista_de_pontos =
          escalarObjeto(last_obj.lista_de_pontos, double.parse(value));
    } catch (e) {
      print("Error: " + e.toString());
    }

    lista_objetos.add(last_obj);
    return lista_objetos;
  } else if (mode_text == "Reflexao") {
    Object last_obj = lista_objetos[lista_objetos.length - 1];
    lista_objetos.removeAt(lista_objetos.length - 1);

    List<Offset> new_points = [];

    last_obj.lista_de_pontos.forEach((element) {
      double new_dx = element.dx;
      double new_dy = element.dy;

      // Calculando as diferenças em relação ao ponto central
      double dx_diff = element.dx - last_obj.centralPoint.dx;
      double dy_diff = element.dy - last_obj.centralPoint.dy;

      if (value == "y") {
        new_dx = last_obj.centralPoint.dx - dx_diff;
      } else if (value == "x") {
        new_dy = last_obj.centralPoint.dy - dy_diff;
      } else if (value == "xy") {
        new_dx = last_obj.centralPoint.dx - dx_diff;
        new_dy = last_obj.centralPoint.dy - dy_diff;
      }

      new_points.add(Offset(new_dx, new_dy));
    });

    last_obj.lista_de_pontos = new_points;
    lista_objetos.add(last_obj);
    return lista_objetos;
  }
  return lista_objetos;
}
