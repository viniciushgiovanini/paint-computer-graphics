import 'package:flutter/material.dart';
import 'GetIcon.dart';

class VerticalBarScreen extends StatelessWidget {
  final List<Offset> points;

  VerticalBarScreen(this.points);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Color.fromARGB(255, 103, 233, 125),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getIcon(Icons.clear, 35.0, () {
            points.clear();
          })
          // IconButton(
          //   icon: Icon(Icons.clear),
          //   iconSize: 35,
          //   onPressed: () {
          //     points.clear();
          //   },
          // ),
          // SizedBox(height: 20),
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
