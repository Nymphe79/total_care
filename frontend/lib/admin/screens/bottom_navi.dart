import 'package:flutter/material.dart';
import 'package:totalcare/admin/screens/add_service.dart';
import 'package:totalcare/home/screens/home_page.dart';

class AdminBottomNavi extends StatefulWidget {
  static const String adminBottom = '/admin/bottomNavi';
  const AdminBottomNavi({Key? key}) : super(key: key);

  @override
  State<AdminBottomNavi> createState() => _AdminBottomNaviState();
}

class _AdminBottomNaviState extends State<AdminBottomNavi> {
  int _currentIndex = 0;
  List<Widget> page = [
    const HomePage(),
    const AddService(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (val) {
            setState(() {
              _currentIndex = val;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'Add Service'),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph_outlined), label: 'Graph'),
          ]),
      body: page[_currentIndex],
    );
  }
}
