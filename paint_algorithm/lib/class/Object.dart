import 'package:flutter/material.dart';
import 'Points.dart';

class Object {
  List<Points> lista_de_pontos = [];
  int lastId = 0;
  String type = "Ponto";
  // String tool = "";

  // void setTool(String tool) {
  //   this.tool = tool;
  // }

  // String getTool() {
  //   return this.tool;
  // }

  void setType(String type) {
    this.type = type;
  }

  String getType() {
    return this.type;
  }

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

  Object mergerTwoObjects(Object one, Object two) {
    Object new_object = new Object();
    new_object.setLastId(one.lastId);
    new_object.setListaPonto(one.lista_de_pontos);

    two.lista_de_pontos.forEach((element) {
      element.id_pixel = one.lastId;
      new_object.lista_de_pontos.add(element);
    });

    return new_object;
  }

  List<Offset> mergeAllPointstoListOffset(Object one) {
    List<Offset> resp = [];

    one.lista_de_pontos.forEach((each_points) {
      resp.add(each_points.ponto);
    });

    return resp;
  }

  bool verificarSeObjetoEPoligono(Object obj, Offset ponto_selecionado) {
    List<Points> lista_de_pontos = [];
    lista_de_pontos.addAll(obj.lista_de_pontos);

    for (var element in lista_de_pontos) {
      if (element.ponto == ponto_selecionado) {
        return true;
      }
    }
    return false;
  }
}
