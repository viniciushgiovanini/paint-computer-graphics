import 'package:flutter/material.dart';

// meus imports
import "../class/Object.dart";
import '../algorithms/transformacoes.dart';

// ignore: must_be_immutable
class GetGestureMouse extends StatefulWidget {
  final Function(List<Offset>) attOffset;
  final Function(List<Object>) attListaObject;
  final String mode_text;
  final String mode_algoritmo;
  final List<Offset> points_class;
  List<Object> lista_objetos;

  GetGestureMouse({
    super.key,
    required this.attListaObject,
    required this.lista_objetos,
    required this.points_class,
    required this.attOffset,
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
        if (!widget.points_class.contains(Offset(
            details.localPosition.dx.roundToDouble(),
            details.localPosition.dy.roundToDouble()))) {
          if (widget.mode_text == "Painter") {
            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));

            widget.attOffset([
              Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble())
            ]);
          }
        }
      },
      onPanUpdate: (details) {
        if (!widget.points_class.contains(Offset(
            details.localPosition.dx.roundToDouble(),
            details.localPosition.dy.roundToDouble()))) {
          if (widget.mode_text == "Painter") {
            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            widget.attOffset([
              Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble())
            ]);
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
            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));

            Object new_object = new Object();

            new_object.setListaPonto([points_unico]);
            widget.lista_objetos.add(new_object);
          } else {
            // CONTINUA OBJETO

            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));

            Object old_object =
                widget.lista_objetos[widget.lista_objetos.length - 1];
            widget.lista_objetos.remove(old_object);
            old_object.lista_de_pontos.add(points_unico);
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

              points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                  details.localPosition.dy.roundToDouble()));

              Object old_object =
                  widget.lista_objetos[widget.lista_objetos.length - 1];
              widget.lista_objetos.remove(old_object);

              old_object.lista_de_pontos.add(points_unico);
              old_object.setType("Reta_do_Poligono");
              widget.lista_objetos.add(old_object);
              // Atualiza lista de objetos com um novo objeto com um unico PONTO dentro.
              // widget.attListaObject(widget.lista_objetos);
            }
          } else {
            // #####

            // CRIA UM NOVO PONTO DO POLIGONO ZERADO.

            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));

            Object new_object = new Object();

            new_object.setListaPonto([points_unico]);
            widget.lista_objetos.add(new_object);
          }
        } else if (widget.mode_text == "Translacao") {
          points_unico = (Offset(details.localPosition.dx.roundToDouble(),
              details.localPosition.dy.roundToDouble()));
          Object elemento_transladar =
              widget.lista_objetos[widget.lista_objetos.length - 1];
          widget.lista_objetos.removeAt(widget.lista_objetos.length - 1);

          elemento_transladar.lista_de_pontos = transladarObjeto(
              elemento_transladar.lista_de_pontos, points_unico);
          widget.lista_objetos.add(elemento_transladar);
        }
        widget.attListaObject(widget.lista_objetos);
      },
    );
  }
}
