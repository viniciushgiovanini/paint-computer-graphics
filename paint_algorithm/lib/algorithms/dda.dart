import 'package:flutter/material.dart';

List<Offset> paintDDA(Offset ponto_inicial, Offset ponto_final) {
  List<Offset> lista_de_pontos_resultdo_do_dda = [];

  double x1 = ponto_inicial.dx.roundToDouble();
  double y1 = ponto_inicial.dy.roundToDouble();
  double x2 = ponto_final.dx.roundToDouble();
  double y2 = ponto_final.dy.roundToDouble();
  double x_incre, y_incre, x, y;

  double dx = x2 - x1;
  double dy = y2 - y1;

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
  Offset ponto_final_arredondado =
      Offset(ponto_final.dx.roundToDouble(), ponto_final.dy.roundToDouble());
  lista_de_pontos_resultdo_do_dda.add(ponto_final_arredondado);

  return lista_de_pontos_resultdo_do_dda;
}
