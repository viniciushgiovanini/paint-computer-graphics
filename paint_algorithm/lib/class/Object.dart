import 'package:flutter/material.dart';
import 'Points.dart';

class Object {
  List<Points> lista_de_pontos = [];
  int lastId = 0;

  void setListaPonto(List<Points> lista_de_pontos) {
    this.lista_de_pontos = lista_de_pontos;
  }

  void setLastId(int lastId) {
    this.lastId = lastId;
  }

  List<Points> getListaPonto() {
    return this.lista_de_pontos;
  }

  int getlastId() {
    return this.lastId;
  }

  void appendNovoPonto(Offset ponto_offset, int id) {
    Points novo_points = new Points();
    novo_points.setOffset(ponto_offset);
    novo_points.setPixelId(id);

    this.lista_de_pontos.add(novo_points);
    this.lastId = id;
  }

  List<Points> objectListtoPointsList(List<Object> lista_de_objeto) {
    List<Points> ret = [];
    lista_de_objeto.forEach((each_object) {
      each_object.lista_de_pontos.forEach((each_points) {
        ret.add(each_points);
      });
    });
    return ret;
  }
}
