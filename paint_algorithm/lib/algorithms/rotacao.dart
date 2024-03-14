import 'package:flutter/material.dart';
import 'dart:math';
import '../class/Object.dart';
import '../class/Points.dart';

Object rotacaoObject(Object obj, double angle, Offset center) {
  Object obj_rotacionado = new Object();

  for (var each_points in obj.lista_de_pontos) {
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
    new_point.setOffset(Offset(rotatedX, rotatedY));
    obj_rotacionado.lista_de_pontos.add(new_point);
  }

  return obj_rotacionado;
}
