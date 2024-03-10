import 'package:flutter/material.dart';
import '../class/Object.dart';

Object paintDDA(Object objeto_inicial, Object objeto_final) {
  Object objeto_resultdo_do_dda = new Object();
  int id_objeto_resultado_dda = objeto_inicial.lastId;

  double x1 = objeto_inicial.lista_de_pontos[0].ponto.dx.roundToDouble();
  double y1 = objeto_inicial.lista_de_pontos[0].ponto.dy.roundToDouble();
  double x2 = objeto_final.lista_de_pontos[0].ponto.dx.roundToDouble();
  double y2 = objeto_final.lista_de_pontos[0].ponto.dy.roundToDouble();
  double x_incre, y_incre, x, y;

  double dx = x2 - x1;
  double dy = y2 - y1;

  // points.clear();

  int passos;

  if (dx.abs() > dy.abs()) {
    passos = dx.abs().toInt();
  } else {
    passos = dy.abs().toInt();
  }

  x_incre = dx / passos;
  y_incre = dy / passos;
  x = x1;
  y = y1;

  // set_pixe(round(x), round(y))
  objeto_resultdo_do_dda.appendNovoPonto(
      Offset(x.roundToDouble(), y.roundToDouble()), id_objeto_resultado_dda);

  for (var k = 1; k < passos; k++) {
    x = x + x_incre;
    y = y + y_incre;
    // set_pixe(round(x), round(y))
    objeto_resultdo_do_dda.appendNovoPonto(
        Offset(x.roundToDouble(), y.roundToDouble()), id_objeto_resultado_dda);
  }

  // Adicionando o ultimo ponto
  objeto_resultdo_do_dda.appendNovoPonto(
      objeto_final.lista_de_pontos[0].ponto, id_objeto_resultado_dda);

  return objeto_resultdo_do_dda;
}
