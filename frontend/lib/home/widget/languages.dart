import 'package:flutter/material.dart';

class Languages extends StatefulWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  Locale? _locale;

  void setLocal(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              setLocal(Locale.fromSubtags(languageCode: 'de'));
            },
            child: Text('Set to english'))
      ],
    );
  }
}
