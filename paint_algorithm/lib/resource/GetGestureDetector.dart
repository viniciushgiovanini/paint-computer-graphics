import 'package:flutter/material.dart';
import 'dart:math';

// meus imports
import "../class/Object.dart";
import '../algorithms/transformacoes.dart';
import '../algorithms/cohen_sutherland.dart';

// ignore: must_be_immutable
class GetGestureMouse extends StatefulWidget {
  final Function(List<Offset>) attOffset;
  final Function(List<Object>) attListaObject;
  final String mode_text;
  final String mode_algoritmo;
  final List<Offset> points_class;
  List<Object> lista_objetos;
  final String mode_recorte;

  GetGestureMouse({
    super.key,
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

class _GetGestureMouseState extends State<GetGestureMouse> {
  Offset points_unico = Offset(0.0, 0.0);
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
          retaCirc(
              widget.mode_text, widget.lista_objetos, points_unico, details);
        } else if (widget.mode_text == "Poligono") {
          poligono(widget.lista_objetos, points_unico, details);
        } else if (widget.mode_text == "Translacao") {
          translacao(widget.lista_objetos, points_unico, details);
        } else if (widget.mode_text == "Recorte") {
          if (widget.mode_recorte == "Cohen-Sutherland") {
            recorte(
                widget.lista_objetos, points_unico, details, cohenSutherland);
          } else if (widget.mode_recorte == "Liang-Barsky") {
            recorte(
                widget.lista_objetos, points_unico, details, cohenSutherland);
          }

          // Gerando tabela
        }
        widget.attListaObject(widget.lista_objetos);
      },
    );
  }
}

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

void poligono(
    List<Object> lista_objetos, Offset points_unico, TapDownDetails details) {
  if (lista_objetos.length != 0 &&
      (lista_objetos[lista_objetos.length - 1].type == "Reta_do_Poligono" ||
          lista_objetos[lista_objetos.length - 1].type == "Ponto")) {
    // Esse if implica que a lista tem que existe e o elemento não pode ser um poligono para continuar, assim tendo que ser um ponto
    if (lista_objetos[0].verificarSeObjetoEPoligono(
        lista_objetos[lista_objetos.length - 1],
        Offset(details.localPosition.dx.roundToDouble(),
            details.localPosition.dy.roundToDouble()))) {
      // CONDICAO DE PARADA PARA DESCONECTAR O POLIGONO

      Object poligono_final = new Object();

      poligono_final.setListaPonto(
          lista_objetos[lista_objetos.length - 1].lista_de_pontos);
      poligono_final.setType("Poligono");
      poligono_final.lista_de_pontos.add(poligono_final.lista_de_pontos.first);
      poligono_final.calculateCentralPoint();
      lista_objetos.removeAt(lista_objetos.length - 1);
      lista_objetos.add(poligono_final);
      // attListaObject(lista_objetos);
    } else {
      // Cria A SEQUENCIA DO POLIGONO

      points_unico = (Offset(details.localPosition.dx.roundToDouble(),
          details.localPosition.dy.roundToDouble()));

      Object old_object = lista_objetos[lista_objetos.length - 1];
      lista_objetos.remove(old_object);

      old_object.lista_de_pontos.add(points_unico);
      old_object.setType("Reta_do_Poligono");
      lista_objetos.add(old_object);
      // Atualiza lista de objetos com um novo objeto com um unico PONTO dentro.
      // attListaObject(lista_objetos);
    }
  } else {
    // #####

    // CRIA UM NOVO PONTO DO POLIGONO ZERADO.

    points_unico = (Offset(details.localPosition.dx.roundToDouble(),
        details.localPosition.dy.roundToDouble()));

    Object new_object = new Object();

    new_object.setListaPonto([points_unico]);
    lista_objetos.add(new_object);
  }
}

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

void recorte(List<Object> lista_objetos, Offset points_unico,
    TapDownDetails details, Function recorteFunc) {
  points_unico = (Offset(details.localPosition.dx.roundToDouble(),
      details.localPosition.dy.roundToDouble()));

  if (lista_objetos.length > 0 &&
      lista_objetos[lista_objetos.length - 1].type == "Ponto") {
    Object new_object_rectangle_cut = new Object();

    new_object_rectangle_cut.lista_de_pontos = generateRectanglePoints(
        lista_objetos[lista_objetos.length - 1].lista_de_pontos[0],
        points_unico);
    new_object_rectangle_cut.setType("Retangulo");
    lista_objetos.removeAt(lista_objetos.length - 1);
    if ((new_object_rectangle_cut.lista_de_pontos[0].dx ==
            new_object_rectangle_cut
                .lista_de_pontos[
                    new_object_rectangle_cut.lista_de_pontos.length - 1]
                .dx) &&
        new_object_rectangle_cut.lista_de_pontos[0].dx <
            new_object_rectangle_cut.lista_de_pontos[1].dx &&
        new_object_rectangle_cut.lista_de_pontos[0].dy ==
            new_object_rectangle_cut.lista_de_pontos[1].dy) {
      List<Object> lista_loop_object = List<Object>.from(lista_objetos);

      lista_loop_object.forEach((each_object) {
        // Object new_object = each_object.deepCopy();
        Object new_reta = new Object();
        new_reta.setType("Reta");
        if (each_object.type != "Circunferencia") {
          for (var i = 0; i < each_object.lista_de_pontos.length - 1; i++) {
            Offset startPoint = each_object.lista_de_pontos[i];
            Offset endPoint = each_object.lista_de_pontos[i + 1];
            // Lista temporária para armazenar os novos pontos
            List<Offset> resp = [];
            // Chamada da função para calcular os novos pontos
            recorteFunc(
              startPoint,
              endPoint,
              new_object_rectangle_cut,
              resp,
              0,
            );

            // Adicionar os novos pontos à lista temporária
            if (resp.isNotEmpty) {
              new_reta.lista_de_pontos.addAll(resp);
            } else {
              new_reta.lista_de_pontos.add(startPoint);
            }

            lista_objetos.add(new_reta);
            new_reta = new Object();
            new_reta.setType("Reta");
          }

          // Definir a lista de pontos atualizada no novo objeto
          // new_object.setListaPonto(novosPontos);

          // Remover o objeto original e adicionar o novo objeto à lista
          lista_objetos.remove(each_object);
          // lista_objetos.add(new_object);
        }
      });
      lista_objetos.insert(0, new_object_rectangle_cut);
      // chamar algs
    }
    "".toString();
  } else {
    points_unico = (Offset(details.localPosition.dx.roundToDouble(),
        details.localPosition.dy.roundToDouble()));

    Object new_object = new Object();

    new_object.setListaPonto([points_unico]);
    lista_objetos.add(new_object);
  }
}
