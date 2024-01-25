import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String text;


  const TextInputField({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
     
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
