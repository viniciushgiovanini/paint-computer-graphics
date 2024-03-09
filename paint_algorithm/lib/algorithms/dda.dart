import 'package:flutter/material.dart';

List<Offset> paintDDA(List<Offset> points) {
  double x1 = points[0].dx.roundToDouble();
  double y1 = points[0].dy.roundToDouble();
  double x2 = points[1].dx.roundToDouble();
  double y2 = points[1].dy.roundToDouble();
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
  points.insert(1, Offset(x.roundToDouble(), y.roundToDouble()));

  for (var k = 1; k < passos; k++) {
    x = x + x_incre;
    y = y + y_incre;
    // set_pixe(round(x), round(y))
    points.insert(k + 1, Offset(x.roundToDouble(), y.roundToDouble()));
  }
  return points;
}
