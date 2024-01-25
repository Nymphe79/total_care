import 'package:flutter/material.dart';


class RadioBtn extends StatelessWidget {
  final dynamic value;
  final Function(dynamic) onTap;
  final dynamic groupValue;
  final String text;
  const RadioBtn(
      {Key? key,
      required this.value,
      required this.onTap,
      required this.groupValue,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 150,
     
        child:  ListTile(
            leading:
                Radio(
                  activeColor: Colors.red,
                  
                  value: value, groupValue: groupValue, onChanged: onTap),
                title:  Text(text,style: TextStyle(color: Colors.black),),
          ),
        );
  }
}
