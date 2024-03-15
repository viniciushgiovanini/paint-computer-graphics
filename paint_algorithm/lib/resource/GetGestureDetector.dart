import 'package:flutter/material.dart';
import 'package:paint_algorithm/class/Points.dart';

// meus imports
import "../class/Object.dart";

// ignore: must_be_immutable
class GetGestureMouse extends StatefulWidget {
  final Function(List<Points>) attPoints;
  final Function(List<Object>) attListaObject;
  final String mode_text;
  final String mode_algoritmo;
  final List<Points> points_class;
  List<Object> lista_objetos;

  GetGestureMouse({
    super.key,
    required this.attListaObject,
    required this.lista_objetos,
    required this.points_class,
    required this.attPoints,
    required this.mode_text,
    required this.mode_algoritmo,
  });

  @override
  State<GetGestureMouse> createState() => _GetGestureMouseState();
}

class _GetGestureMouseState extends State<GetGestureMouse> {
  Offset points_unico = Offset(0.0, 0.0);
  bool trava = false;
  final List<Offset> save_pontos_att = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        Points newObject = new Points();
        if (!newObject.isList(
            widget.points_class,
            Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()))) {
          if (widget.mode_text == "Painter") {
            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            newObject.setOffset(points_unico);
            widget.attPoints([newObject]);
          }
        }
      },
      onPanUpdate: (details) {
        Points newObject = new Points();
        if (!newObject.isList(
            widget.points_class,
            Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()))) {
          if (widget.mode_text == "Painter") {
            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            newObject.setOffset(points_unico);
            widget.attPoints([newObject]);
          }
        }
      },
      onTapDown: (details) {
        if (widget.mode_text == "Reta" ||
            widget.mode_text == "Circunferencia") {
          if (widget.lista_objetos.length == 0 ||
              widget.lista_objetos[widget.lista_objetos.length - 1]
                      .lista_de_pontos.length ==
                  2 ||
              widget.lista_objetos[widget.lista_objetos.length - 1].type ==
                  "Poligono") {
            // INICIA NOVO OBJETO

            Points new_point = new Points();

            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            new_point.setOffset(points_unico);

            Object new_object = new Object();

            new_object.setListaPonto([new_point]);
            widget.lista_objetos.add(new_object);
          } else {
            // CONTINUA OBJETO

            Points new_point = new Points();

            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            new_point.setOffset(points_unico);

            Object old_object =
                widget.lista_objetos[widget.lista_objetos.length - 1];
            widget.lista_objetos.remove(old_object);
            old_object.lista_de_pontos.add(new_point);
            old_object.setType(widget.mode_text);
            widget.lista_objetos.add(old_object);
          }
        } else if (widget.mode_text == "Poligono") {
          if (widget.lista_objetos.length != 0 &&
              (widget.lista_objetos[widget.lista_objetos.length - 1].type ==
                      "Reta_do_Poligono" ||
                  widget.lista_objetos[widget.lista_objetos.length - 1].type ==
                      "Ponto")) {
            // Esse if implica que a lista tem que existe e o elemento não pode ser um poligono para continuar, assim tendo que ser um ponto
            if (widget.lista_objetos[0].verificarSeObjetoEPoligono(
                widget.lista_objetos[widget.lista_objetos.length - 1],
                Offset(details.localPosition.dx.roundToDouble(),
                    details.localPosition.dy.roundToDouble()))) {
              // CONDICAO DE PARADA PARA DESCONECTAR O POLIGONO

              Object poligono_final = new Object();

              poligono_final.setListaPonto(widget
                  .lista_objetos[widget.lista_objetos.length - 1]
                  .lista_de_pontos);
              poligono_final.setType("Poligono");
              widget.lista_objetos.removeAt(widget.lista_objetos.length - 1);
              widget.lista_objetos.add(poligono_final);
              // widget.attListaObject(widget.lista_objetos);
            } else {
              // Cria A SEQUENCIA DO POLIGONO
              Points new_point = new Points();

              points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble()));
              new_point.setOffset(points_unico);

              Object old_object =
                  widget.lista_objetos[widget.lista_objetos.length - 1];
              widget.lista_objetos.remove(old_object);

              old_object.lista_de_pontos.add(new_point);
              old_object.setType("Reta_do_Poligono");
              widget.lista_objetos.add(old_object);
              // Atualiza lista de objetos com um novo objeto com um unico PONTO dentro.
              // widget.attListaObject(widget.lista_objetos);
            }
          } else {
            // #####

            // CRIA UM NOVO PONTO DO POLIGONO ZERADO.
            Points new_point = new Points();

            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            new_point.setOffset(points_unico);

            Object new_object = new Object();

            new_object.setListaPonto([new_point]);
            widget.lista_objetos.add(new_object);
          }
        }
        widget.attListaObject(widget.lista_objetos);
      },
    );
  }
}
