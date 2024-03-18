import 'package:flutter/material.dart';

// imports arq
import "./page/homepage.dart";

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => MyHomePage();
}

// Widget principal, faz a chamada do appbar (cabeçalho) e o container que tem a barra lateral e o canvas chamado Viewer
class MyHomePage extends State<Home> {
  String mode_text = "Painter";
  // Variaveis que setam o modo dos algoritmos de reta e recorte
  String mode_algoritmo = "DDA";
  String mode_recorte = "Cohen-Sutherland";

  @override
  @override
  Widget build(BuildContext context) {
    // Widget: Cabecalho
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "PAINT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(234, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Modo: $mode_text",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color.fromARGB(234, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Color.fromARGB(255, 103, 233, 125),
          ),
          // Widget: Canvas e barra vertica
          body: Container(
            decoration: BoxDecoration(color: Colors.blueGrey[900]),
            // Chamada do canvas e da barra lateral
            child: ViewerInteractive(
              updateModeRecorte: (p0) {
                setState(() {
                  mode_recorte = p0;
                });
              },
              mode_recorte: mode_recorte,
              mode_algoritmo: mode_algoritmo,
              mode_text: mode_text,
              updateModeAlgoritmo: (details) {
                setState(() {
                  mode_algoritmo = details;
                });
              },
              updateStringMode: (details) {
                setState(() {
                  mode_text = details;
                });
              },
            ),
          )),
    );
  }
}
