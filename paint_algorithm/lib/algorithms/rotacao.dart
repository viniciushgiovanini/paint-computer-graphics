import 'package:flutter/material.dart';
import 'dart:math';
import '../class/Object.dart';

Object rotacaoObject(Object obj, double angle, Offset center) {
  List<Offset> lista_de_pontos = List<Offset>.from(obj.lista_de_pontos);

  obj.lista_de_pontos.clear();

  for (var each_points in lista_de_pontos) {
    double x = each_points.dx;
    double y = each_points.dy;
    double radians = angle * (pi / 180);

    // Aplicando a rotação
    double rotatedX = (x - center.dx) * cos(radians) -
        (y - center.dy) * sin(radians) +
        center.dx;
    double rotatedY = (x - center.dx) * sin(radians) +
        (y - center.dy) * cos(radians) +
        center.dy;

    obj.lista_de_pontos
        .add(Offset(rotatedX.roundToDouble(), rotatedY.roundToDouble()));
  }

  return obj;
}
