import 'package:flutter/material.dart';

List<Offset> paintBresenham(List<Offset> points) {
  int x1 = points[0].dx.roundToDouble().toInt();
  int y1 = points[0].dy.roundToDouble().toInt();
  int x2 = points[1].dx.roundToDouble().toInt();
  int y2 = points[1].dy.roundToDouble().toInt();

  int d = 0;

  int dx = (x2 - x1).abs();
  int dy = (y2 - y1).abs();

  int dx2 = 2 * dx;
  int dy2 = 2 * dy;

  int incrementalx = x1 < x2 ? 1 : -1;
  int incrementaly = y1 < y2 ? 1 : -1;

  int x = x1;
  int y = y1;

  points.clear();

  if (dx >= dy) {
    while (true) {
      points.add(Offset(x.toDouble(), y.toDouble()));
      if (x == x2) break;
      x += incrementalx;
      d += dy2;
      if (d > dx) {
        y += incrementaly;
        d -= dx2;
      }
    }
  } else {
    while (true) {
      points.add(Offset(x.toDouble(), y.toDouble()));
      if (y == y2) break;
      y += incrementaly;
      d += dx2;
      if (d > dy) {
        x += incrementalx;
        d -= dy2;
      }
    }
  }

  return points;
}
