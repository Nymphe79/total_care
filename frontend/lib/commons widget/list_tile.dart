import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic)? onChanged;
  final String text;
  
  const CustomListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
        ListTile(
          leading:
              Radio(value: value, groupValue: groupValue, onChanged: onChanged),
          title: Text(text),
        
    );
  }
}
