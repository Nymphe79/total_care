import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/home/screens/home_page.dart';
import 'package:totalcare/home/screens/your_booking.dart';
import 'package:totalcare/models/services.dart';
import 'package:totalcare/provider/theme_provider.dart';

class BottomNavi extends StatefulWidget {
  static const String bottomNavi = '/bottomNavi';

  const BottomNavi({Key? key}) : super(key: key);

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  int _currentIndex = 0;
  late Service service;

  List<Widget> list = [
    const HomePage(),
    const YourBooking(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:
       CustomNavigationBar(
          currentIndex: _currentIndex,
          selectedColor: navbarColor,
          unSelectedColor: unselectedItemColor,
          onTap: (val) {
            _currentIndex = val;
            setState(() {
              
            });
          },
          items: [
            CustomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            CustomNavigationBarItem(
                icon: Icon(Icons.book_online), title: Text('Your Booking')),
    
              
          ]),
          body: list[_currentIndex],
    );
        
  }
}
