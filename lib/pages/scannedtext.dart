import 'package:flutter/material.dart';

class ScannedText extends StatefulWidget {
  const ScannedText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _ScannedTextState createState() => _ScannedTextState();
}

class _ScannedTextState extends State<ScannedText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scanned Text"),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: SelectableText(
              widget.text.isEmpty ? "No Text Found" : widget.text),
        ));
  }
}
