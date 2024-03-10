import 'package:flutter/material.dart';
import '../class/Object.dart';

Object paintBresenhamGeneric(Object objeto_inicial, Object objeto_final) {
  Object objeto_resultdo_do_bresenham = new Object();
  int id_objeto_resultado_bresenham = objeto_inicial.lastId;

  int x1 = objeto_inicial.lista_de_pontos[0].ponto.dx.roundToDouble().toInt();
  int y1 = objeto_inicial.lista_de_pontos[0].ponto.dy.roundToDouble().toInt();
  int x2 = objeto_final.lista_de_pontos[0].ponto.dx.roundToDouble().toInt();
  int y2 = objeto_final.lista_de_pontos[0].ponto.dy.roundToDouble().toInt();

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
  objeto_resultdo_do_bresenham.appendNovoPonto(
      Offset(x.roundToDouble(), y.roundToDouble()),
      id_objeto_resultado_bresenham);

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
      objeto_resultdo_do_bresenham.appendNovoPonto(
          Offset(x.roundToDouble(), y.roundToDouble()),
          id_objeto_resultado_bresenham);
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
      objeto_resultdo_do_bresenham.appendNovoPonto(
          Offset(x.roundToDouble(), y.roundToDouble()),
          id_objeto_resultado_bresenham);
      // points.add(Offset(x.roundToDouble(), y.roundToDouble()));
    }
  }

  return objeto_resultdo_do_bresenham;
}
