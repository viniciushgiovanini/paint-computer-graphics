import 'package:flutter/material.dart';

class VerticalBarScreen extends StatelessWidget {
  final List<Offset> points;

  VerticalBarScreen(this.points);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      color: Color.fromARGB(255, 167, 166, 164),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              points.clear();
            },
          ),
          // SizedBox(height: 20), // Espaçamento entre os botões
          // IconButton(
          //   icon: Icon(Icons.remove),
          //   onPressed: () {
          //     // Ação do botão 2
          //   },
          // ),
        ],
      ),
    );
  }
}
