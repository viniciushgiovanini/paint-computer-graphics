import 'package:flutter/material.dart';

class DrawingObject {
  Offset ponto = Offset(0.0, 0.0);
  int id_pixel = 0;

  // DrawingObject();

  Offset getPoint() {
    return this.ponto;
  }

  int getDesenhado() {
    return this.id_pixel;
  }

  void setOffset(Offset ponto) {
    this.ponto = ponto;
  }

  void setPixelId(int pixel_id) {
    this.id_pixel = pixel_id;
  }

  bool isList(List<DrawingObject> drawing_object, Offset value) {
    for (var element in drawing_object) {
      if (element.ponto == value) {
        return true;
      }
    }
    return false;
  }
}
