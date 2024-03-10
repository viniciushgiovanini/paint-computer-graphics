import 'package:flutter/material.dart';

class Points {
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

  // verificar se o Ponto é de um objeto ou é um pixel solo
  bool isSoloPixel(List<Points> lista_de_points) {
    return lista_de_points.length == 1 ? true : false;
  }
}
