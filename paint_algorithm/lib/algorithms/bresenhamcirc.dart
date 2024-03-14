import 'package:flutter/material.dart';
import '../class/Points.dart';

List<Offset> paintCirc(Points ponto_inicial, Points ponto_final) {
  List<Offset> novo_objeto = [];
  int x, y;
  int p;

  double distancia = (ponto_inicial.ponto - ponto_final.ponto).distance;

  int r = distancia.toInt();

  int xc = ponto_inicial.ponto.dx.toInt();
  int yc = ponto_inicial.ponto.dy.toInt();

  // INICIO DO ALGORITMO

  x = 0;
  y = r;
  p = 3 - 2 * r;
  // PROCEDIMENTO
  novo_objeto.addAll(plot_circle_ponts(xc, x, yc, y));
  while (x < y) {
    if (p < 0) {
      p = p + 4 * x + 6;
    } else {
      p = p + 4 * (x - y) + 10;
      y = y - 1;
    }
    x = x + 1;
    // PLOTAR
    novo_objeto.addAll(plot_circle_ponts(xc, x, yc, y));
  }
  return novo_objeto;
}

List<Offset> plot_circle_ponts(int xc, int x, int yc, int y) {
  // set_pixel(xc+x, yc+y)
  List<Offset> novo_ponto = [];
  novo_ponto.add(Offset((xc + x).roundToDouble(), (yc + y).roundToDouble()));
  // set_pixel(xc-x, yc+y)
  novo_ponto.add(Offset((xc - x).roundToDouble(), (yc + y).roundToDouble()));
  // set_pixel(xc+x, yc-y )
  novo_ponto.add(Offset((xc + x).roundToDouble(), (yc - y).roundToDouble()));
  // set_pixel(xc-x, yc-y);
  novo_ponto.add(Offset((xc - x).roundToDouble(), (yc - y).roundToDouble()));
  // set_pixel(xc+y, yc+x)
  novo_ponto.add(Offset((xc + y).roundToDouble(), (yc + x).roundToDouble()));
  // set_pixel(xc-y, yc+x)
  novo_ponto.add(Offset((xc - y).roundToDouble(), (yc + x).roundToDouble()));
  // set_pixel(xc+y, yc-x)
  novo_ponto.add(Offset((xc + y).roundToDouble(), (yc - x).roundToDouble()));
  // set_pixel(xc-y, yc-x)
  novo_ponto.add(Offset((xc - y).roundToDouble(), (yc - x).roundToDouble()));

  return novo_ponto;
}
