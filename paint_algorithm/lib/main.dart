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

  @override
  Widget build(BuildContext context) {
    return Container(child: MouseClickCoordinatesWidget(
      onClick: (p0) {
        print(p0);
      },
    ));
  }
}

// #####################
// Classe do Painter
// #####################


// CustomPaint(
//       size: Size(300, 300),
//       painter: Canva(points),
//     )

// class Canva extends CustomPainter {
//   final List<Offset> points; // Use a lista de pontos passada como parâmetro

//   Canva(this.points);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color.fromARGB(255, 0, 0, 0)
//       ..strokeWidth = 5.0;

//     final double boxSize = 15;
//     final double maxX = size.width;
//     final double maxY = size.height;

//     for (double i = 0; i <= maxX; i += boxSize) {
//       canvas.drawLine(Offset(i, 0), Offset(i, maxY), paint);
//     }

//     for (double i = 0; i <= maxY; i += boxSize) {
//       canvas.drawLine(Offset(0, i), Offset(maxX, i), paint);
//     }

//     Offset pontoEspecifico = Offset(300, 400);

//     // Desenha todos os pontos na lista
//     // points.forEach((point) {
//     //   canvas.drawPoints(PointMode.points, [point], paint); // Corrigindo aqui
//     // });

//     canvas.drawPoints(PointMode.points, [pontoEspecifico], paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
