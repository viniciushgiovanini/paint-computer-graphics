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
              mode_text: mode_text,
              updateStringMode: (details) {
                setState(() {
                  mode_text = details;
                  print("MODEL TEXT = $details");
                });
              },
            ),
          )),
    );
  }
}
