import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String text;
  final TextEditingController controller;


  const TextInput({Key? key, required this.text, required this.controller,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return 'Enter $text';
        }
      },
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
