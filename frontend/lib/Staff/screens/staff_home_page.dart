import 'package:flutter/material.dart';
import 'package:totalcare/Staff/services/staff_service.dart';
import 'package:totalcare/models/staff.dart';

class StaffHomePage extends StatefulWidget {
  static const String staffHome = '/staff/home';
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  final staffService = StaffService();
List<Staff> staffs = [];

  @override
  void initState() {
    
    super.initState();
    dataOfStaff();
  }

dataOfStaff()async{
 

  setState(() {
    
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          
          crossAxisCount: 2,
        mainAxisSpacing: 2), 
        itemCount: staffs.length,
      itemBuilder: (context,index){
        var data = staffs[index];
        return Text(data.name);
      })
    );
  }
}
