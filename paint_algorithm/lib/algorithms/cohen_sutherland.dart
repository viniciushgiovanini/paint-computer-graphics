import 'package:flutter/material.dart';
import '../class/Object.dart';

void cohenSutherland(
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

  double xmax = area_rec.lista_de_pontos[2].dx;
  double ymax = area_rec.lista_de_pontos[2].dy;
  double xmin = area_rec.lista_de_pontos[0].dx;
  double ymin = area_rec.lista_de_pontos[0].dy;

  bool aceite = false;
  bool feito = false;

  while (!feito) {
    int c1 = regionCode(x1, y1, xmin, xmax, ymin, ymax);
    int c2 = regionCode(x2, y2, xmin, xmax, ymin, ymax);

    if (c1 == 0 && c2 == 0) {
      // Segmento completamente dentro
      aceite = true;
      feito = true;
    } else if ((c1 & c2) != 0) {
      // Segmento completamente fora
      feito = true;
    } else {
      int cfora = (c1 != 0) ? c1 : c2;

      double xint, yint;
      if ((cfora & 1) == 1) {
        // Limite esquerdo
        xint = xmin;
        yint = y1 + (y2 - y1) * (xmin - x1) / (x2 - x1);
      } else if ((cfora & 2) == 2) {
        // Limite direito
        xint = xmax;
        yint = y1 + (y2 - y1) * (xmax - x1) / (x2 - x1);
      } else if ((cfora & 4) == 4) {
        // Limite baixo
        yint = ymin;
        xint = x1 + (x2 - x1) * (ymin - y1) / (y2 - y1);
      } else {
        // Limite acima
        yint = ymax;
        xint = x1 + (x2 - x1) * (ymax - y1) / (y2 - y1);
      }

      if (c1 == cfora) {
        x1 = xint;
        y1 = yint;
      } else {
        x2 = xint;
        y2 = yint;
      }
    }
  }

  if (aceite) {
    while (lista_resp.length <= index + 1) {
      lista_resp.add(Offset.zero);
    }
    lista_resp[index] = Offset(x1, y1);
    lista_resp[index + 1] = Offset(x2, y2);
  }
}

int regionCode(
    double x, double y, double xmin, double xmax, double ymin, double ymax) {
  int codigo = 0;

  if (x < xmin) {
    codigo += 1;
  }
  if (x > xmax) {
    codigo += 2;
  }
  if (y < ymin) {
    codigo += 4;
  }
  if (y > ymax) {
    codigo += 8;
  }

  return codigo;
}
