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

class MyHomePage extends State<Home> {
  String mode_text = "Painter";
  String mode_algoritmo = "DDA";
  String mode_recorte = "Cohen-Sutherland";

  @override
  @override
  Widget build(BuildContext context) {
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
          body: Container(
            decoration: BoxDecoration(color: Colors.blueGrey[900]),
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
