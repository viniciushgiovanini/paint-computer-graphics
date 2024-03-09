import 'package:flutter/material.dart';

List<Offset> paintBresenhamV0(List<Offset> points) {
  int x1 = points[0].dx.roundToDouble().toInt();
  int y1 = points[0].dy.roundToDouble().toInt();
  int x2 = points[1].dx.roundToDouble().toInt();
  int y2 = points[1].dy.roundToDouble().toInt();

  int dx, dy, y, x, const1, const2, p;

  dx = (x2 - x1).abs();
  dy = (y2 - y1).abs();
  p = (2 * dy) - dx;
  const1 = 2 * dy;
  const2 = 2 * (dy - dx);
  x = x1;
  y = y1;

  points.clear();
  points.add(Offset(x.toDouble(), y.toDouble()));

  int incrementX = x2 > x1 ? 1 : -1;
  int incrementY = y2 > y1 ? 1 : -1;

  bool isVerticalReta = false;

  if (x1 == x2) {
    isVerticalReta = true;
  }

  while ((incrementX == 1 && x < x2) ||
      (incrementX == -1 && x > x2) ||
      (incrementY == 1 && y < y2) ||
      (incrementY == -1 && y > y2)) {
    if (p < 0) {
      p += const1;
    } else if (!isVerticalReta) {
      p += const2;
      y += incrementY;
    } else if (isVerticalReta) {
      y += incrementY;
    }

    if (!isVerticalReta) {
      x += incrementX;
    }
    points.add(Offset(x.toDouble(), y.toDouble()));
  }

  return points;
}
