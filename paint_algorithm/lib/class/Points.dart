import 'package:flutter/material.dart';

class Points {
  Offset ponto = Offset(0.0, 0.0);

  // DrawingObject();

  Offset getPoint() {
    return this.ponto;
  }

  void setOffset(Offset ponto) {
    this.ponto = ponto;
  }

// verifica se o offset existe na lista de Points
  bool isList(List<Points> points_class, Offset value) {
    for (var element in points_class) {
      if (element.ponto == value) {
        return true;
      }
    }
    return false;
  }
}
