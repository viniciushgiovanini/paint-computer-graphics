import 'package:flutter/material.dart';
import 'dart:math';
import '../class/Object.dart';

Object rotacaoObject(Object obj, double angle) {
  List<Offset> lista_de_pontos = List<Offset>.from(obj.lista_de_pontos);

  Offset center = obj.centralPoint;
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

    obj.lista_de_pontos.add(Offset(rotatedX, rotatedY));
  }

  return obj;
}

List<Offset> transladarObjeto(
    List<Offset> pontosObjeto, Offset novoPontoInicial) {
  // Calcula o vetor de translação
  Offset vetorTranslacao = Offset(
    novoPontoInicial.dx - pontosObjeto[0].dx,
    novoPontoInicial.dy - pontosObjeto[0].dy,
  );

  // Lista para armazenar os pontos transladados
  List<Offset> pontosTransladados = [];

  pontosTransladados.add(novoPontoInicial);

  // Translada cada ponto do objeto
  for (int i = 1; i < pontosObjeto.length; i++) {
    Offset novoPonto = Offset(
      pontosObjeto[i].dx + vetorTranslacao.dx,
      pontosObjeto[i].dy + vetorTranslacao.dy,
    );
    pontosTransladados.add(novoPonto);
  }

  return pontosTransladados;
}

List<Offset> escalarObjeto(List<Offset> pontos, double fatorEscala) {
  Offset pontoDeReferencia = pontos[0];
  // Calcula o deslocamento do ponto de referência para o ponto de origem (0, 0)
  double deltaX = pontoDeReferencia.dx;
  double deltaY = pontoDeReferencia.dy;

  // Lista para armazenar os pontos escalados
  List<Offset> pontosEscalados = [];

  // Aplica a escala a todos os pontos, mantendo o ponto de referência fixo
  pontos.forEach((ponto) {
    double novoX = deltaX + (ponto.dx - deltaX) * fatorEscala;
    double novoY = deltaY + (ponto.dy - deltaY) * fatorEscala;
    pontosEscalados.add(Offset(novoX, novoY));
  });

  return pontosEscalados;
}
