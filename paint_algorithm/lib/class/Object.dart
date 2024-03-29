import 'package:flutter/material.dart';

// A classe objeto tem uma lista de offset
// tem o tipo, podendo ser ponto, reta, poligono ou circunferencia
// toda vez que um objeto é criado sem ponto central é atualizado, isso ocorre
// para ja ter esse ponto nas operações de movimento do objeto.
class Object {
  List<Offset> lista_de_pontos = [];
  String type = "Ponto";
  Offset centralPoint = Offset(0.0, 0.0);

  void setType(String type) {
    this.type = type;
  }

  String getType() {
    return this.type;
  }

  void setListaPonto(List<Offset> lista_de_pontos) {
    this.lista_de_pontos = lista_de_pontos;
  }

  List<Offset> getListaPonto() {
    return this.lista_de_pontos;
  }

  // Verifica se o objeto poligono esta fechado
  bool verificarSeObjetoEPoligono(Object obj, Offset ponto_selecionado) {
    List<Offset> lista_de_pontos = [];
    lista_de_pontos.addAll(obj.lista_de_pontos);

    for (var element in lista_de_pontos) {
      if (element == ponto_selecionado) {
        return true;
      }
    }
    return false;
  }

  // Metodo que recebe um objeto, e dependedo do tipo ele calcula o ponto central
  void calculateCentralPoint() {
    if (type == "Reta") {
      this.centralPoint = Offset(
          ((this.lista_de_pontos[0].dx + this.lista_de_pontos[1].dx) / 2)
              .roundToDouble(),
          ((this.lista_de_pontos[0].dy + this.lista_de_pontos[1].dy) / 2)
              .roundToDouble());
    } else if (type == "Poligono") {
      double somaX = 0;
      double somaY = 0;

      for (Offset vertice in this.lista_de_pontos) {
        somaX += vertice.dx;
        somaY += vertice.dy;
      }

      double pontoCentralX = somaX / this.lista_de_pontos.length;
      double pontoCentralY = somaY / this.lista_de_pontos.length;

      this.centralPoint =
          Offset(pontoCentralX.roundToDouble(), pontoCentralY.roundToDouble());
    } else if (type == "Circunferencia") {
      this.centralPoint = lista_de_pontos[0];
    }
  }

  // Metodo de clonar objeto
  Object clone() {
    final clonedObject = Object();
    clonedObject.lista_de_pontos.addAll(lista_de_pontos);
    clonedObject.type = type;
    clonedObject.centralPoint = centralPoint;
    return clonedObject;
  }
}
