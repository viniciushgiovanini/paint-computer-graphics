import 'package:flutter/material.dart';
import 'dart:math';
import '../class/Object.dart';
import '../class/Points.dart';

Object rotacaoObject(Object obj, double angle, Offset center) {
  List<Points> lista_de_pontos = List<Points>.from(obj.lista_de_pontos);

  obj.lista_de_pontos.clear();

  for (var each_points in lista_de_pontos) {
    double x = each_points.ponto.dx;
    double y = each_points.ponto.dy;
    double radians = angle * (pi / 180);

    // Aplicando a rotação
    double rotatedX = (x - center.dx) * cos(radians) -
        (y - center.dy) * sin(radians) +
        center.dx;
    double rotatedY = (x - center.dx) * sin(radians) +
        (y - center.dy) * cos(radians) +
        center.dy;

    Points new_point = new Points();
    new_point
        .setOffset(Offset(rotatedX.roundToDouble(), rotatedY.roundToDouble()));
    obj.lista_de_pontos.add(new_point);
  }

  return obj;
}
