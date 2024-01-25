import 'package:flutter/material.dart';

import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/models/services.dart';

class Cards extends StatelessWidget {
  final String text;
  final List<String> image;
  final String price;


  const Cards(
      {Key? key, required this.text, required this.image, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border.all(color: unselectedItemColor),
                  image: DecorationImage(
                      image: NetworkImage(
                        image[0],
                      ),
                      fit: BoxFit.cover)),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 100,
                width: 130,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    border: Border.all(color: unselectedItemColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      price,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
