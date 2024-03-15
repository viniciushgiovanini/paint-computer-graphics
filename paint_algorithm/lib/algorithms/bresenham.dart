import 'package:flutter/material.dart';

List<Offset> paintBresenhamGeneric(Offset ponto_inicial, Offset ponto_final) {
  List<Offset> objeto_resultdo_do_bresenham = [];

  int x1 = ponto_inicial.dx.roundToDouble().toInt();
  int y1 = ponto_inicial.dy.roundToDouble().toInt();
  int x2 = ponto_final.dx.roundToDouble().toInt();
  int y2 = ponto_final.dy.roundToDouble().toInt();

  int dx, dy, x, y, i, const1, const2, p, increx, increy;

  dx = x2 - x1;
  dy = y2 - y1;
  if (dx >= 0) {
    increx = 1;
  } else {
    increx = -1;
    dx = -dx;
  }
  if (dy >= 0) {
    increy = 1;
  } else {
    increy = -1;
    dy = -dy;
  }
  x = x1;
  y = y1;

  // points.clear();
  // points.add(Offset(x.roundToDouble(), y.roundToDouble()));
  objeto_resultdo_do_bresenham
      .add(Offset(x.roundToDouble(), y.roundToDouble()));
  ;

  if (dy < dx) {
    p = 2 * dy - dx;
    const1 = 2 * dy;
    const2 = 2 * (dy - dx);
    for (i = 0; i < dx; i++) {
      x += increx;
      if (p < 0) {
        p += const1;
      } else {
        y += increy;
        p += const2;
      }
      objeto_resultdo_do_bresenham
          .add(Offset(x.roundToDouble(), y.roundToDouble()));
      // points.add(Offset(x.roundToDouble(), y.roundToDouble()));
    }
  } else {
    p = 2 * dx - dy;
    const1 = 2 * dx;
    const2 = 2 * (dx - dy);
    for (var i = 0; i < dy; i++) {
      y += increy;
      if (p < 0) {
        p += const1;
      } else {
        x += increx;
        p += const2;
      }
      objeto_resultdo_do_bresenham
          .add(Offset(x.roundToDouble(), y.roundToDouble()));
      // points.add(Offset(x.roundToDouble(), y.roundToDouble()));
    }
  }

  return objeto_resultdo_do_bresenham;
}
