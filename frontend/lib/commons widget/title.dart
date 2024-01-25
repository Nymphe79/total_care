import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final Color color;
  final Alignment textAlign;

  const CustomTitle({
    Key? key, required this.title, required this.color,
    required this.textAlign
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:textAlign ,
      child: Text(
        title,
        
        style: TextStyle(fontSize: 25, color: color),
      ),
    );
  }
}
