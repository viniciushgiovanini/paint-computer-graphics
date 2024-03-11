import 'package:flutter/material.dart';
import 'GetRadioListTile.dart';

int groupValue = 0;

class meuDialogWidget extends StatefulWidget {
  final List<String> listText;
  final List<String> descricao;
  final String title;
  final Function(String) updateModeAlg;
  meuDialogWidget(
      {super.key,
      required this.listText,
      required this.descricao,
      required this.title,
      required this.updateModeAlg});

  @override
  State<meuDialogWidget> createState() => _meuDialogWidgetState();
}

class _meuDialogWidgetState extends State<meuDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          Text(widget.title),
          getRadioListTile(0, groupValue, (p0) {
            setState(() {
              if (p0 == widget.listText[0]) {
                groupValue = 0;
                widget.updateModeAlg(widget.listText[0]);
              }
            });
          }, widget.listText, widget.descricao[0]),
          getRadioListTile(1, groupValue, (p0) {
            setState(() {
              if (p0 == widget.listText[1]) {
                groupValue = 1;
                widget.updateModeAlg(widget.listText[1]);
              }
            });
          }, widget.listText, widget.descricao[1]),
          Divider()
        ],
      ),
    );
  }
}

Future<void> getDialog(
    BuildContext context, final Function(String) updateModeAlg) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Selecionar Algoritmo'),
        content: Container(
          width: 800,
          height: 400,
          child: meuDialogWidget(
            listText: ["DDA", "Bresenham"],
            descricao: [
              "Algoritmo para plot de retas DDA",
              "Algoritmo para plot de retas Bresenham"
            ],
            title: "Algoritmo de Retas",
            updateModeAlg: updateModeAlg,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}


// #######################################
// METODO PARA NÃO PERDER O VALOR DO BOTÃO
// #######################################