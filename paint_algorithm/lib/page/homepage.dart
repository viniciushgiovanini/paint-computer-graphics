import 'package:flutter/material.dart';
import "dart:ui";

// Imports
// import "../resource/GetMouseLeftClick.dart";
import "../resource/VerticalBarScrean.dart";
import '../resource/GetGestureDetector.dart';

// Classe
import '../class/Object.dart';

// Algs
import '../algorithms/dda.dart';
import '../algorithms/bresenham.dart';
import '../algorithms/bresenhamcirc.dart';
import '../algorithms/cohen_sutherland.dart';
import '../algorithms/liang_barski.dart';

// ###########################
// Classe do ViewerInteractive
// ###########################
// ignore: must_be_immutable
class ViewerInteractive extends StatefulWidget {
  String mode_text;
  String mode_algoritmo;
  String mode_recorte;
  void Function(String) updateStringMode;
  void Function(String) updateModeAlgoritmo;
  void Function(String) updateModeRecorte;

  ViewerInteractive(
      {super.key,
      required this.updateModeRecorte,
      required this.mode_recorte,
      required this.mode_text,
      required this.mode_algoritmo,
      required this.updateStringMode,
      required this.updateModeAlgoritmo});

  @override
  State<ViewerInteractive> createState() => _ViewerInteractiveState();
}

class _ViewerInteractiveState extends State<ViewerInteractive> {
  List<Offset> points_class = [];
  final double width = 300;
  final double height = 300.5;
  List<Object> lista_objetos = [];
  List<List<Object>> savedStates = [];
  int currentStateIndex = -1;
  int atualStateElement = 0;
  var cut_object = null;

  // Callback utilizada para atualizar o valor do modo de recorte
  void updateModeCutObj(dynamic value) {
    setState(() {
      cut_object = value;
    });
  }

  // Metodo utilizado para a feature do botão de desfazer, atualiza uma segunda
  //lista que armazena até 10 estados da lista de objetos
  void saveState() {
    final currentState = lista_objetos.map((obj) => obj.clone()).toList();
    if (currentStateIndex < savedStates.length - 1) {
      savedStates.removeRange(currentStateIndex + 1, savedStates.length);
    }
    if (savedStates.length >= 10) {
      savedStates.removeAt(0);
    }
    savedStates.add(currentState);
    currentStateIndex = savedStates.length - 1;
  }

  // Método para desfazer a última alteração na lista de objetos
  void undo() {
    if (currentStateIndex > 0) {
      currentStateIndex--;
      setState(() {
        lista_objetos =
            savedStates[currentStateIndex].map((obj) => obj.clone()).toList();
      });
    }
  }

  // Método para avançar uma alteração na lista de objetos
  void redo() {
    if (currentStateIndex < savedStates.length - 1) {
      currentStateIndex++;
      setState(() {
        lista_objetos =
            savedStates[currentStateIndex].map((obj) => obj.clone()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          height: height,
          // Widget: responsavel pelo dinamismo do canvas, zoom in e out alem da navegacao
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(0.0),
            minScale: 0.1,
            maxScale: 60.0,
            // Chamada do canvas que leva ao custom painter
            child: CanvaWidget(
              updateModeCutObj: updateModeCutObj,
              cut_object: cut_object,
              attListaObject: (p0) {
                setState(() {
                  lista_objetos = p0;
                  saveState();
                });
              },
              mode_recorte: widget.mode_recorte,
              points_class: points_class,
              width: width,
              height: height,
              mode_algoritmo: widget.mode_algoritmo,
              mode_text: widget.mode_text,
              updateOffset: (updatedPoints) {
                points_class.addAll(updatedPoints);
              },
              lista_objetos: lista_objetos,
            ),
          ),
        )),
        // Chamada da barra vertical, onde estão os botões.
        VerticalBarScreen(
          savedStates: savedStates,
          updateModeRecorte: (p0) {
            setState(() {
              widget.updateModeRecorte(p0);
            });
          },
          mode_text: widget.mode_text,
          attListaObject: (p0) {
            setState(() {
              lista_objetos = p0;
            });
          },
          lista_objetos: lista_objetos,
          updateModeAlgoritmo: (p0) {
            widget.updateModeAlgoritmo(p0);
          },
          points_class: points_class,
          // Call back responsavel de mudar o valor do modo, de acordo com o botão acessado.
          updateMode: (txt_mode) {
            if (widget.mode_text == "Poligono" && lista_objetos.length != 0) {
              setState(() {
                cut_object = null;
                Object last_polygon = lista_objetos.last;
                lista_objetos.remove(last_polygon);

                last_polygon.calculateCentralPoint();

                lista_objetos.add(last_polygon);
              });
            }

            if (txt_mode == "Voltar" && lista_objetos.length != 0) {
              if (currentStateIndex > 0) {
                undo();
              }
            } else if (txt_mode == "Avancar" && lista_objetos.length != 0) {
              if (currentStateIndex < savedStates.length - 1) {
                redo();
              }
            }
            widget.updateStringMode(txt_mode);
          },
        ),
      ],
    );
  }
}

// Widget responsavel por administrar as chamadas ao custom painter
// ignore: must_be_immutable
class CanvaWidget extends StatefulWidget {
  final List<Offset> points_class;
  final Function(List<Object>) attListaObject;
  final double width;
  final double height;
  final Function(List<Offset>) updateOffset;
  final List<Object> lista_objetos;
  final String mode_algoritmo;
  final String mode_text;
  final String mode_recorte;
  final void Function(dynamic) updateModeCutObj;
  var cut_object;

  CanvaWidget({
    super.key,
    required this.updateModeCutObj,
    required this.cut_object,
    required this.mode_recorte,
    required this.attListaObject,
    required this.lista_objetos,
    required this.points_class,
    required this.width,
    required this.height,
    required this.updateOffset,
    required this.mode_text,
    required this.mode_algoritmo,
  });

  @override
  State<CanvaWidget> createState() => _CanvaWidgetState();
}

// #####################
// Classe do Canva
// #####################
class _CanvaWidgetState extends State<CanvaWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Chamada ao custom painter, passando como parametro os valores para
        // ele chamar os algoritmos necessários
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: Canva(
            mode_recorte: widget.mode_recorte,
            points_class: widget.points_class,
            lista_de_objetos_oficial: widget.lista_objetos,
            mode_algoritmo: widget.mode_algoritmo,
            mode_text: widget.mode_text,
          ),
          // Chamada da classe de gestos, responsavel pelos inputs do mouse
          child: GetGestureMouse(
            updateModeCutObj: widget.updateModeCutObj,
            cut_object: widget.cut_object,
            mode_recorte: widget.mode_recorte,
            // Atualiza a lista de objetos de acordo com o input passado
            attListaObject: (p0) {
              setState(() {
                widget.attListaObject(p0);
              });
            },
            points_class: widget.points_class,
            mode_text: widget.mode_text,
            mode_algoritmo: widget.mode_algoritmo,
            // Atualiza a lista de offset, aqui serve para a ferramenta de
            // desenho livre que é um array de offset somente
            attOffset: (pontos_att) {
              setState(() {
                widget.updateOffset(pontos_att);
              });
            },
            lista_objetos: widget.lista_objetos,
          ),
        ),
      ),
    );
  }
}

// #####################
// Classe do Painter
// #####################

class Canva extends CustomPainter {
  List<Offset> points_class = [];
  final List<Object> lista_de_objetos_oficial;
  String mode_algoritmo = "";
  String mode_text = "";
  String mode_recorte = "";

  Canva({
    required this.mode_recorte,
    required this.points_class,
    required this.lista_de_objetos_oficial,
    required this.mode_algoritmo,
    required this.mode_text,
  });

  // metodo responsavel pela pintura no canvas.
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 1.0;

    final paintRectange = Paint()
      ..color = Color.fromARGB(255, 2, 121, 27)
      ..strokeWidth = 1.0;

    // Copiar a lista de objeto, passando a nova para os algoritmos, que caso
    // seja modificado a primaria mantem os valores para manter as atualizações em tempo real.
    List<Object> lista_de_objetos = lista_de_objetos_oficial.map((obj) {
      Object copia_objeto = Object();
      copia_objeto.lista_de_pontos =
          List.from(obj.lista_de_pontos); // Cópia da lista de pontos
      copia_objeto.type = obj.type; // Atribuição do tipo
      copia_objeto.centralPoint = Offset(
          obj.centralPoint.dx, obj.centralPoint.dy); // Cópia do ponto central
      return copia_objeto;
    }).toList();

    Paint backgroundPaint = Paint()..color = Color.fromARGB(240, 255, 255, 255);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Aqui está as chamadas dos algoritmos para realizar as pinturas.
    if (lista_de_objetos.length >= 1) {
      Object new_object_rectangle_cut = lista_de_objetos[0];

      // Verifica se é algoritmo de recorte
      if (new_object_rectangle_cut.type == "Retangulo") {
        if (mode_recorte == "Cohen-Sutherland") {
          paintRecorte(new_object_rectangle_cut, lista_de_objetos,
              cohenSutherland, canvas, paint);
        } else if (mode_recorte == "Liang-Barsky") {
          paintRecorte(new_object_rectangle_cut, lista_de_objetos, liangBarsky,
              canvas, paint);
        }
      }
    }
    // Chamada para desenhar na ferramenta de desenho mão livre
    if (points_class.length >= 1) {
      points_class.forEach((point) {
        canvas.drawPoints(PointMode.points, [point], paint);
      });
    }
    // Chamada para desenho de retas
    if (lista_de_objetos.length >= 1) {
      paintVerify(lista_de_objetos, mode_text, mode_algoritmo, canvas, paint,
          paintRectange);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

bool setTwoPoints(Object objeto) {
  if (objeto.lista_de_pontos.length >= 2) {
    return true;
  }
  return false;
}

// Aqui está o metodo para fazer a logica de quando chamar cada algoritmo,
// para DDA bresenham CIRC bresenham ou desenhar o retangulo do recorte,
// recebe o modo para escolher qual metodo usar com cada funcao do algoritmo
// passado como parametro.
void paintVerify(List<Object> lista_de_objetos, String mode_text,
    String mode_algoritmo, Canvas canvas, Paint paint, Paint paintRectange) {
  lista_de_objetos.forEach((element) {
    if (element.type != "Ponto" && element.type != "Circunferencia") {
      if (mode_algoritmo == "DDA") {
        if (element.type == "Retangulo") {
          paintRetas(mode_text, mode_algoritmo, canvas, paintRectange, element,
              paintDDA);
        } else {
          paintRetas(
              mode_text, mode_algoritmo, canvas, paint, element, paintDDA);
        }
      } else {
        if (element.type == "Retangulo") {
          paintRetas(mode_text, mode_algoritmo, canvas, paintRectange, element,
              paintBresenhamGeneric);
        } else {
          paintRetas(mode_text, mode_algoritmo, canvas, paint, element,
              paintBresenhamGeneric);
        }
      }
    } else if (element.type == "Circunferencia") {
      canvas.drawPoints(
          PointMode.points,
          paintCirc(element.lista_de_pontos[element.lista_de_pontos.length - 2],
              element.lista_de_pontos[element.lista_de_pontos.length - 1]),
          paint);
    } else {
      canvas.drawPoints(
          PointMode.points,
          [
            Offset(
                lista_de_objetos[lista_de_objetos.length - 1]
                    .lista_de_pontos[0]
                    .dx,
                lista_de_objetos[lista_de_objetos.length - 1]
                    .lista_de_pontos[0]
                    .dy)
          ],
          paint);
    }
  });
}

// Metodo que gerencia o algoritmo de recorte.
void paintRecorte(Object new_object_rectangle_cut, List<Object> lista_objetos,
    Function recorteFunc, Canvas canvas, Paint paint) {
  List<Object> lista_loop_object = List<Object>.from(lista_objetos);
  lista_loop_object.forEach((each_object) {
    Object new_reta = new Object();

    if (each_object.type != "Circunferencia" &&
        each_object.type != "Retangulo" &&
        each_object.type != "Ponto") {
      int index_each_object = lista_objetos.indexOf(each_object);

      String obj_type = each_object.type;
      new_reta.setType(obj_type);
      lista_objetos.remove(each_object);
      for (var i = 0; i < each_object.lista_de_pontos.length - 1; i++) {
        Offset startPoint = each_object.lista_de_pontos[i];
        Offset endPoint = each_object.lista_de_pontos[i + 1];
        List<Offset> resp = [];
        recorteFunc(
          startPoint,
          endPoint,
          new_object_rectangle_cut,
          resp,
          0,
        );

        if (resp.isNotEmpty) {
          new_reta.lista_de_pontos.addAll(resp);
        } else {
          new_reta.lista_de_pontos.add(startPoint);
        }

        lista_objetos.insert(index_each_object, new_reta);
        index_each_object++;
        new_reta = new Object();

        new_reta.setType(obj_type);
      }
    }
  });
}

// Metodo Final que recebe a lista de objetos e passa para o drawPoints o metodo de reta referente.
void paintRetas(
  String mode_text,
  String mode_algoritmo,
  Canvas canvas,
  Paint paint,
  Object element,
  Function paintFunction,
) {
  for (int i = 0; i < element.lista_de_pontos.length - 1; i++) {
    Offset elemento_atual = element.lista_de_pontos[i];
    Offset elemento_prox = element.lista_de_pontos[i + 1];

    canvas.drawPoints(
        PointMode.points, paintFunction(elemento_atual, elemento_prox), paint);
  }
}
