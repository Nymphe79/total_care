import 'package:flutter/material.dart';
import 'package:totalcare/constant/global_variables.dart';


class TextIcon extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final  String text;
  const TextIcon({Key? key, required this.onPressed,required this.icon,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(onPressed: onPressed, icon: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon,color: normalColor,),
    ), label: Text(text,
    style: const TextStyle(
      color: normalColor,
      fontSize: 25
    ),
    ),);
  }
}
