import 'package:flutter/material.dart';

class Object {
  List<Offset> lista_de_pontos = [];
  String type = "Ponto";

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
}
