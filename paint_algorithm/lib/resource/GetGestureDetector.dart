import 'package:flutter/material.dart';
import 'dart:math';

// meus imports
import "../class/Object.dart";
import '../algorithms/transformacoes.dart';

// ignore: must_be_immutable
class GetGestureMouse extends StatefulWidget {
  final Function(List<Offset>) attOffset;
  final Function(List<Object>) attListaObject;
  final void Function(dynamic) updateModeCutObj;
  final String mode_text;
  final String mode_algoritmo;
  final List<Offset> points_class;
  List<Object> lista_objetos;
  final String mode_recorte;
  var cut_object;

  GetGestureMouse({
    super.key,
    required this.updateModeCutObj,
    required this.cut_object,
    required this.mode_recorte,
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

// Widget que recebe os inputs dos gestos.
class _GetGestureMouseState extends State<GetGestureMouse> {
  Offset points_unico = Offset(0.0, 0.0);
  final List<Offset> save_pontos_att = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Gestos de iniciar o arrasto do mouse
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
      // Gesto que atualizando quando o mouse1 esta clicado e arrastando, colocando todos
      // os offets em uma lista para mandar para o custom painter
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
      // Gesto referente ao clique do mouse, que manda o input de maneiras diferentes para
      // a lista de objetos
      onTapDown: (details) {
        if (widget.mode_text == "Reta" ||
            widget.mode_text == "Circunferencia") {
          retaCirc(
              widget.mode_text, widget.lista_objetos, points_unico, details);
        } else if (widget.mode_text == "Poligono") {
          poligono(widget.lista_objetos, points_unico, details,
              widget.cut_object, widget.updateModeCutObj);
        } else if (widget.mode_text == "Translacao") {
          translacao(widget.lista_objetos, points_unico, details);
        } else if (widget.mode_text == "Recorte") {
          recorte(widget.lista_objetos, points_unico, details);
        }
        widget.attListaObject(widget.lista_objetos);
      },
    );
  }
}

// Metodo que gera as coordenadas dos pontos extremos da diagonal secundario, pois
// tem que ser passado a diagonal principal
List<Offset> generateRectanglePoints(Offset point1, Offset point2) {
  double minX = min(point1.dx, point2.dx);
  double minY = min(point1.dy, point2.dy);
  double maxX = max(point1.dx, point2.dx);
  double maxY = max(point1.dy, point2.dy);

  // Mantém os pontos da diagonal principal fixos
  Offset topLeft = point1;
  Offset bottomRight = point2;

  // Calcula os outros dois pontos da diagonal secundária
  Offset topRight = Offset(maxX, minY);
  Offset bottomLeft = Offset(minX, maxY);

  return [topLeft, topRight, bottomRight, bottomLeft, point1];
}

// #########################
//     FUNCOES DO ONTAP
// #########################
// Recebe o primeiro input e adiciona um objeto ponto, e quando recebe
//o outro input transforma em um objetos circunferencia.
void retaCirc(String mode_text, List<Object> lista_objetos, Offset points_unico,
    TapDownDetails details) {
  if (lista_objetos.length == 0 ||
      lista_objetos[lista_objetos.length - 1].lista_de_pontos.length == 2 ||
      lista_objetos[lista_objetos.length - 1].type == "Poligono") {
    // INICIA NOVO OBJETO
    points_unico = (Offset(details.localPosition.dx.roundToDouble(),
        details.localPosition.dy.roundToDouble()));

    Object new_object = new Object();

    new_object.setListaPonto([points_unico]);
    lista_objetos.add(new_object);
  } else {
    // CONTINUA OBJETO

    points_unico = (Offset(details.localPosition.dx.roundToDouble(),
        details.localPosition.dy.roundToDouble()));

    Object old_object = lista_objetos[lista_objetos.length - 1];
    lista_objetos.remove(old_object);
    old_object.lista_de_pontos.add(points_unico);
    old_object.setType(mode_text);
    old_object.calculateCentralPoint();
    lista_objetos.add(old_object);
  }
}

// Gerencia a ferramenta de poligono, fazendo um conjunto de retas ligadas, e quando voce
// clica em outra ferramenta ele fecha o objeto desenhado
void poligono(List<Object> lista_objetos, Offset points_unico,
    TapDownDetails details, var cut_object, Function updateCutObject) {
  if (cut_object == null || lista_objetos.length == 0) {
    // CONDICAO DE PARADA PARA DESCONECTAR O POLIGONO

    cut_object = "rodando";
    updateCutObject(cut_object);
    // CRIA UM NOVO PONTO DO POLIGONO ZERADO.

    points_unico = (Offset(details.localPosition.dx.roundToDouble(),
        details.localPosition.dy.roundToDouble()));

    Object new_object = new Object();

    new_object.setListaPonto([points_unico]);
    lista_objetos.add(new_object);
    // attListaObject(lista_objetos);
  } else {
    // Cria A SEQUENCIA DO POLIGONO
    cut_object = "rodando";
    updateCutObject(cut_object);
    points_unico = (Offset(details.localPosition.dx.roundToDouble(),
        details.localPosition.dy.roundToDouble()));

    Object old_object = lista_objetos[lista_objetos.length - 1];
    lista_objetos.remove(old_object);

    old_object.lista_de_pontos.add(points_unico);
    old_object.setType("Poligono");
    lista_objetos.add(old_object);
    // Atualiza lista de objetos com um novo objeto com um unico PONTO dentro.
  }
}

// ########################
// #      Translacao      #
// ########################
// Metodo que realiza a translação, no ponto inicial do objeto
void translacao(
    List<Object> lista_objetos, Offset points_unico, TapDownDetails details) {
  points_unico = (Offset(details.localPosition.dx.roundToDouble(),
      details.localPosition.dy.roundToDouble()));
  Object elemento_transladar = lista_objetos[lista_objetos.length - 1];
  lista_objetos.removeAt(lista_objetos.length - 1);

  elemento_transladar.lista_de_pontos =
      transladarObjeto(elemento_transladar.lista_de_pontos, points_unico);
  elemento_transladar.calculateCentralPoint();
  lista_objetos.add(elemento_transladar);
}

// Metodo que recebe a lista de objetos que gera o retangulo, adiciondo sempre na primeira posicao
// dos objetos, caso tenha um retangulo já ele faz o update.
void recorte(
    List<Object> lista_objetos, Offset points_unico, TapDownDetails details) {
  points_unico = (Offset(details.localPosition.dx.roundToDouble(),
      details.localPosition.dy.roundToDouble()));

  if (lista_objetos.length > 0 &&
      lista_objetos[lista_objetos.length - 1].type == "Ponto") {
    Object new_object_rectangle_cut = new Object();

    if (lista_objetos[0].type == "Retangulo") {
      lista_objetos.removeAt(0);
    }

    new_object_rectangle_cut.lista_de_pontos = generateRectanglePoints(
        lista_objetos[lista_objetos.length - 1].lista_de_pontos[0],
        points_unico);

    if ((new_object_rectangle_cut.lista_de_pontos[0].dx ==
            new_object_rectangle_cut
                .lista_de_pontos[
                    new_object_rectangle_cut.lista_de_pontos.length - 1]
                .dx) &&
        new_object_rectangle_cut.lista_de_pontos[0].dx <
            new_object_rectangle_cut.lista_de_pontos[1].dx &&
        new_object_rectangle_cut.lista_de_pontos[0].dy ==
            new_object_rectangle_cut.lista_de_pontos[1].dy) {
      new_object_rectangle_cut.setType("Retangulo");
      lista_objetos.removeAt(lista_objetos.length - 1);
      lista_objetos.insert(0, new_object_rectangle_cut);
    } else {
      lista_objetos.removeLast();
    }
  } else {
    points_unico = (Offset(details.localPosition.dx.roundToDouble(),
        details.localPosition.dy.roundToDouble()));

    Object new_object = new Object();

    new_object.setListaPonto([points_unico]);
    lista_objetos.add(new_object);
  }
}
