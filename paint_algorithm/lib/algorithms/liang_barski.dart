import 'package:flutter/material.dart';
import '../class/Object.dart';

List<dynamic> cliptest(double p, double q, double u1, double u2) {
  bool result = true;
  double updatedU1 = u1;
  double updatedU2 = u2;

  if (p < 0.0) {
    double r = q / p;
    if (r > u2) {
      result = false;
    } else if (r > u1) {
      updatedU1 = r;
    }
  } else if (p > 0.0) {
    double r = q / p;
    if (r < u1) {
      result = false;
    } else if (r < u2) {
      updatedU2 = r;
    }
  } else if (q < 0.0) {
    result = false;
  }

  return [result, updatedU1, updatedU2];
}

void liangBarsky(
  Offset ponto1,
  Offset ponto2,
  Object area_rec,
  List<Offset> lista_resp,
  int index,
) {
  double x1 = ponto1.dx;
  double y1 = ponto1.dy;
  double x2 = ponto2.dx;
  double y2 = ponto2.dy;

  double xjmax = area_rec.lista_de_pontos[2].dx;
  double yjmax = area_rec.lista_de_pontos[2].dy;
  double xjmin = area_rec.lista_de_pontos[0].dx;
  double yjmin = area_rec.lista_de_pontos[0].dy;

  double u1 = 0.0, u2 = 1.0;
  double dx = x2 - x1;
  double dy = y2 - y1;

  var clipResult = cliptest(-dx, x1 - xjmin, u1, u2);
  bool clipTestResult = clipResult[0];
  u1 = clipResult[1];
  u2 = clipResult[2];

  if (clipTestResult) {
    clipResult = cliptest(dx, xjmax - x1, u1, u2);
    clipTestResult = clipResult[0];
    u1 = clipResult[1];
    u2 = clipResult[2];

    if (clipTestResult) {
      clipResult = cliptest(-dy, y1 - yjmin, u1, u2);
      clipTestResult = clipResult[0];
      u1 = clipResult[1];
      u2 = clipResult[2];

      if (clipTestResult) {
        clipResult = cliptest(dy, yjmax - y1, u1, u2);
        clipTestResult = clipResult[0];
        u1 = clipResult[1];
        u2 = clipResult[2];

        if (clipTestResult) {
          if (u2 < 1.0) {
            x2 = x1 + u2 * dx;
            y2 = y1 + u2 * dy;
          }
          if (u1 > 0.0) {
            x1 = x1 + u1 * dx;
            y1 = y1 + u1 * dy;
          }
          while (lista_resp.length <= index + 1) {
            lista_resp.add(Offset.zero);
          }
          lista_resp[index] = Offset(x1, y1);
          lista_resp[index + 1] = Offset(x2, y2);
        }
      }
    }
  }
}
