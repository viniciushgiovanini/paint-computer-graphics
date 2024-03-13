import 'package:flutter/material.dart';
import '../class/Object.dart';
import '../class/Points.dart';

List<Offset> paintDDA(Points ponto_inicial, Points ponto_final) {
  List<Offset> lista_de_pontos_resultdo_do_dda = [];

  double x1 = ponto_inicial.ponto.dx.roundToDouble();
  double y1 = ponto_inicial.ponto.dy.roundToDouble();
  double x2 = ponto_final.ponto.dx.roundToDouble();
  double y2 = ponto_final.ponto.dy.roundToDouble();
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
  lista_de_pontos_resultdo_do_dda
      .add(Offset(x.roundToDouble(), y.roundToDouble()));

  for (var k = 1; k < passos; k++) {
    x = x + x_incre;
    y = y + y_incre;
    // set_pixe(round(x), round(y))
    lista_de_pontos_resultdo_do_dda
        .add(Offset(x.roundToDouble(), y.roundToDouble()));
  }

  lista_de_pontos_resultdo_do_dda.add(ponto_final.ponto);

  return lista_de_pontos_resultdo_do_dda;
}
