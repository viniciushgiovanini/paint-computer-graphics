import 'package:flutter/material.dart';

Widget getIcon(IconData name, double iconSize, void Function() onPressed) {
  return IconButton(icon: Icon(name), iconSize: iconSize, onPressed: onPressed);
}
