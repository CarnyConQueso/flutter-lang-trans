import 'package:flutter/material.dart';
import 'package:myapp/classes/language.dart';
import 'package:translator/translator.dart';

class ScannedText extends StatefulWidget {
  const ScannedText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _ScannedTextState createState() => _ScannedTextState();
}

class _ScannedTextState extends State<ScannedText> {
  @override
  String defaultLanguage = 'en';
  var currentLanguage;
  var translatedMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Scanned Text"), actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              onChanged: (Language? language) {
                currentLanguage = language!;
                // _langSwitch(language);
              },
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: Language.langList()
                  .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                        value: lang,
                        child: Row(
                          mainAxisAlignment: (MainAxisAlignment.spaceAround),
                          children: <Widget>[Text(lang.flag), Text(lang.name)],
                        ),
                      ))
                  .toList(),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _langSwitch(currentLanguage);
            },
            label: const Text('Translate')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: SelectableText(
              widget.text.isEmpty ? "No Text Found" : widget.text),
        ));
  }

  void _langSwitch(language) async {
    final translator = GoogleTranslator();
    if (widget.text.isEmpty) {
      const Text('No Text to Translate');
    } else {
      translatedMessage = await translator.translate(widget.text,
          from: defaultLanguage, to: language.langCode);
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(language.name),
              content: Text(translatedMessage.toString()),
              scrollable: true,
              actions: [
                IconButton(
                    onPressed: () {
                      print('Work in Progress');
                    },
                    icon: const Icon(Icons.volume_up)),
                IconButton(
                    onPressed: () {
                      print('Work in Progress');
                    },
                    icon: const Icon(Icons.image))
              ],
            ));

    print(translatedMessage);
  }
}
