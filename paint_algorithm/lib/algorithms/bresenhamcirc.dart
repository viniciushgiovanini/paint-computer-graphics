import 'package:flutter/material.dart';
import '../class/Object.dart';
import '../class/Points.dart';

Object paintCirc(Object object_inicial, Object object_final) {
  Object novo_objeto = new Object();
  int x, y;
  int p;

  double distancia = (object_inicial.lista_de_pontos[0].ponto -
          object_final.lista_de_pontos[0].ponto)
      .distance;

  int r = distancia.toInt();

  int xc = object_inicial.lista_de_pontos[0].ponto.dx.toInt();
  int yc = object_inicial.lista_de_pontos[0].ponto.dy.toInt();

  // INICIO DO ALGORITMO

  x = 0;
  y = r;
  p = 3 - 2 * r;
  // PROCEDIMENTO
  novo_objeto = plot_circle_ponts(novo_objeto, xc, x, yc, y);
  while (x < y) {
    if (p < 0) {
      p = p + 4 * x + 6;
    } else {
      p = p + 4 * (x - y) + 10;
      y = y - 1;
    }
    x = x + 1;
    // PLOTAR
    novo_objeto = plot_circle_ponts(novo_objeto, xc, x, yc, y);
  }
  return novo_objeto;
}

Object plot_circle_ponts(Object resultado, int xc, int x, int yc, int y) {
  // set_pixel(xc+x, yc+y)
  Points novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc + x).roundToDouble(), (yc + y).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  // set_pixel(xc-x, yc+y)
  novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc - x).roundToDouble(), (yc + y).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  // set_pixel(xc+x, yc-y )
  novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc + x).roundToDouble(), (yc - y).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  // set_pixel(xc-x, yc-y);
  novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc - x).roundToDouble(), (yc - y).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  // set_pixel(xc+y, yc+x)
  novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc + y).roundToDouble(), (yc + x).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  // set_pixel(xc-y, yc+x)
  novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc - y).roundToDouble(), (yc + x).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  // set_pixel(xc+y, yc-x)
  novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc + y).roundToDouble(), (yc - x).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  // set_pixel(xc-y, yc-x)
  novo_ponto = new Points();
  novo_ponto
      .setOffset(Offset((xc - y).roundToDouble(), (yc - x).roundToDouble()));
  resultado.lista_de_pontos.add(novo_ponto);

  return resultado;
}
