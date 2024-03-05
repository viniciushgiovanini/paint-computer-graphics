import 'package:flutter/material.dart';

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
    ));
  }
}
