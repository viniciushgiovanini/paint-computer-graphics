import 'package:flutter/material.dart';
import "./resource/getMouseLeftClick.dart";
import "dart:ui";

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => MyHomePage();
}

class MyHomePage extends State<Home> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("PAINT",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(234, 255, 255, 255))),
          backgroundColor: Color.fromARGB(255, 103, 233, 125),
        ),
        body: CanvaWidget(),
      ),
    );
  }
}

class CanvaWidget extends StatefulWidget {
  const CanvaWidget({super.key});

  @override
  State<CanvaWidget> createState() => _CanvaWidgetState();
}

class _CanvaWidgetState extends State<CanvaWidget> {
  List<Offset> points = [];

  double width = 300;
  double height = 300;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(width, height),
        painter: Canva(points),
        child: MouseClickCoordinatesWidget(
          onClick: (Offset offset) {
            // Aqui você pode lidar com a posição clicada como desejado
            setState(() {
              points.add(offset);
            });
          },
          width: width,
          height: height,
        ),
      ),
      // Adicione outros widgets abaixo, se necessário
    );
  }
}

// #####################
// Classe do Painter
// #####################

class Canva extends CustomPainter {
  List<Offset> points; // Use a lista de pontos passada como parâmetro

  Canva(this.points);

  // Pinte o fundo com uma cor desejada

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 10.0;

    Paint backgroundPaint = Paint()..color = Color.fromARGB(127, 243, 240, 211);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
    // Desenha todos os pontos na lista
    points.forEach((point) {
      canvas.drawPoints(PointMode.points, [point], paint); // Corrigindo aqui
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
