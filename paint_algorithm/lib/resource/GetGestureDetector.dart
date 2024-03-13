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
  final Function(int) updatePixelID_gesture_detector;
  final List<Points> points_class;
  List<Object> lista_objetos;
  int pixel_id;

  GetGestureMouse({
    super.key,
    required this.attListaObject,
    required this.lista_objetos,
    required this.points_class,
    required this.updatePixelID_gesture_detector,
    required this.pixel_id,
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
            newObject.setPixelId(widget.pixel_id);
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
            newObject.setPixelId(widget.pixel_id);
            widget.attPoints([newObject]);
          }
        }
      },
      onTapDown: (details) {
        if (widget.mode_text == "Reta") {
          if (widget.lista_objetos.length == 0 ||
              widget.lista_objetos[widget.lista_objetos.length - 1]
                      .lista_de_pontos.length ==
                  2) {
            Points new_point = new Points();

            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            new_point.setOffset(points_unico);
            new_point.setPixelId(widget.pixel_id);

            Object new_object = new Object();
            new_object.setLastId(widget.pixel_id);
            new_object.setListaPonto([new_point]);
            widget.lista_objetos.add(new_object);
          } else {
            Points new_point = new Points();

            points_unico = (Offset(details.localPosition.dx.roundToDouble(),
                details.localPosition.dy.roundToDouble()));
            new_point.setOffset(points_unico);
            new_point.setPixelId(widget.pixel_id);

            Object old_object =
                widget.lista_objetos[widget.lista_objetos.length - 1];
            widget.lista_objetos.remove(old_object);
            old_object.setLastId(old_object.getlastId());
            old_object.lista_de_pontos.add(new_point);
            widget.lista_objetos.add(old_object);

            // Atualizando PIXEL ID NA RETA
            widget.updatePixelID_gesture_detector(++widget.pixel_id);
          }
        }

        // Atualiza lista de objetos com um novo objeto com um unico PONTO dentro.
        widget.attListaObject(widget.lista_objetos);
      },
      onPanEnd: (details) {
        // int newID = ++widget.pixel_id;
        // widget.updatePixelID_gesture_detector(newID);
      },
      onTapUp: (details) {
        // int newID = ++widget.pixel_id;
        // widget.updatePixelID_gesture_detector(newID);
      },
    );
  }
}

// // #################
// // Funcoes de Check
// // #################

// void paintLine(
//   String mode_algoritmo,
//   List<Offset> save_pontos_att,
//   Offset points_unico,
//   List<Points> points_class,
//   Function(List<Points>) attPoints,
//   List<Object> lista_objetos,
//   Function(List<Object>) attListaObject,
//   Function painterAlg,
// ) {
//   // Lista para verificar se são pontos distintos, para não partir da ultima reta desenhada
//   // if ((mode_algoritmo == "DDA" || mode_algoritmo == "Bresenham")) {
//   save_pontos_att.add(points_unico);
//   if (save_pontos_att.length == 2) {
//     Util obj = new Util();
//     if (lista_objetos.length != 0) {
//       lista_objetos = obj.createListObject(points_class);
//     } else {
//       lista_objetos = obj.createListObject(points_class);
//     }

//     if (lista_objetos.length != 0) {
//       Object objeto_inicial = lista_objetos[lista_objetos.length - 2];
//       Object objeto_final = lista_objetos[lista_objetos.length - 1];

//       // conficao de erro para voce não usar por exemplo dda --> paint --> dda se vc ficar alternando o modo buga a lista de objeto
//       Points new_instance = new Points();

//       if (new_instance.isSoloPixel(objeto_inicial.lista_de_pontos) &&
//           new_instance.isSoloPixel(objeto_final.lista_de_pontos)) {
//         lista_objetos.remove(objeto_inicial);
//         lista_objetos.remove(objeto_final);

//         lista_objetos.add(painterAlg(objeto_inicial, objeto_final));

//         points_class.clear();

//         attPoints(objeto_inicial.objectListtoPointsList(lista_objetos));
//         attListaObject(lista_objetos);
//       }
//     }
//     save_pontos_att.clear();
//   }
// }
// // }

// void paintPolygon(
//   String mode_algoritmo,
//   List<Offset> save_pontos_att,
//   Offset points_unico,
//   List<Points> points_class,
//   Function(List<Points>) attPoints,
//   List<Object> lista_objetos,
//   Function(List<Object>) attListaObject,
//   Function painterAlg,
// ) {
//   if ((mode_algoritmo == "DDA" || mode_algoritmo == "Bresenham")) {
//     if (lista_objetos.length == 0 && save_pontos_att.length != 0) {
//       save_pontos_att.clear();
//     } else {
//       lista_objetos.removeWhere((element) {
//         return element.lastId == -10;
//       });
//     }

//     save_pontos_att.add(points_unico);
//     if (save_pontos_att.length > 1) {
//       Util obj = new Util();
//       lista_objetos = obj.createListObject(points_class);

//       if (lista_objetos.length != 0) {
//         Object objeto_inicial = lista_objetos[lista_objetos.length - 2];

//         Object objeto_final = lista_objetos[lista_objetos.length - 1];

//         lista_objetos.remove(objeto_inicial);
//         lista_objetos.remove(objeto_final);

//         if (objeto_inicial.lista_de_pontos.length > 1) {
//           Object new_obj_incial = new Object();
//           new_obj_incial.lista_de_pontos.add(objeto_inicial
//               .lista_de_pontos[objeto_inicial.lista_de_pontos.length - 1]);
//           print(new_obj_incial);
//           objeto_inicial.lista_de_pontos.removeLast();
//           new_obj_incial = painterAlg(new_obj_incial, objeto_final);
//           new_obj_incial =
//               new_obj_incial.mergerTwoObjects(objeto_inicial, new_obj_incial);
//           List<Offset> lista_verificar_repetido =
//               new_obj_incial.mergeAllPointstoListOffset(new_obj_incial);
//           if (hasDuplicates(lista_verificar_repetido)) {
//             save_pontos_att.clear();
//             new_obj_incial.lista_de_pontos.removeLast();
//           }
//           lista_objetos.add(objeto_inicial);
//         } else {
//           lista_objetos.add(painterAlg(objeto_inicial, objeto_final));
//         }

//         points_class.clear();

//         attPoints(objeto_inicial.objectListtoPointsList(lista_objetos));
//         attListaObject(lista_objetos);
//       }
//     } else {
//       Object obj = new Object();
//       obj.setListaPonto(points_class);
//       obj.setLastId(-10);
//       lista_objetos.add(obj);
//       attListaObject(lista_objetos);
//     }
//   }
// }

// bool hasDuplicates(List<Offset> list) {
//   return list[0] == list[list.length - 1];
// }
