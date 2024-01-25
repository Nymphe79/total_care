import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  const Button({Key? key, required this.text, required this.onTap,required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(text,
          style: TextStyle(color: Colors.black),)),
        ));
  }
}
