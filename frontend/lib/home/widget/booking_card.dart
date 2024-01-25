import 'package:flutter/material.dart';
import 'package:totalcare/constant/global_variables.dart';

class BookingCard extends StatelessWidget {
  final String name;
  final String serviceName;
  final String date;
  final String time;
  final VoidCallback onpressed;

  const BookingCard(
      {Key? key,
      required this.name,
      required this.serviceName,
      required this.date,
      required this.time,
      required this.onpressed
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: backgroundColor)),
        shadowColor: navbarColor,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $name',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                'Service: $serviceName',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                'Date: $date',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                'Time: $time',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                    IconButton(onPressed:onpressed, icon: Icon(Icons.delete)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
