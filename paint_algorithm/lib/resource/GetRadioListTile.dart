import 'package:flutter/material.dart';

Widget getRadioListTile(
  int value,
  int groupValue,
  Function(String?) onChanged,
  List<String> titles,
  String subtitles,
) {
  return RadioListTile<String>(
    title: Text(titles[value]),
    value: titles[value],
    groupValue: titles[groupValue],
    onChanged: onChanged,
    subtitle: Text(subtitles),
  );
}
