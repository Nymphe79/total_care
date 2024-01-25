import 'dart:io';

import 'package:flutter/material.dart';

import 'package:totalcare/constant/utils.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? image  = '';

  chooseImage() async {
    image = await selectImage();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            ClipOval(
              child:
              image!.isNotEmpty? Image.file(
                File(image!),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
              : Text('Hello'),
            ),
            ElevatedButton(
                onPressed: chooseImage,
                child: Text('Press')),
          ],
        ),
      ),
    );
  }
}
