import 'package:flutter/material.dart';
import 'package:totalcare/Staff/services/staff_service.dart';
import 'package:totalcare/admin/services/admin_service.dart';
import 'package:totalcare/appoinment/screens/reservation.dart';

import 'package:totalcare/commons%20widget/loader.dart';
import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/home/screens/navbar.dart';

import 'package:totalcare/home/widget/cards.dart';
import 'package:totalcare/models/member.dart';
import 'package:totalcare/models/services.dart';
import 'package:totalcare/models/staff.dart';

import '../../auth/services/auth_service.dart';

class HomePage extends StatefulWidget {
  static const String page = '/pageScreen';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Member>? staffs;
  List<Staff>? staffList;
  List<Service>? serviceList;
  late Member member;

  final authService = AuthService();
  final staffService = StaffService();
  final adminService = AdminService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStaffData();
    fetchData();
    fetchServices();
  }

  fetchStaffData() async {
    staffs = await authService.fetchStaffData(context);

    setState(() {});
  }

  fetchData() async {
    staffList = await staffService.fetchStaff(context);
    setState(() {});
  }

  fetchServices() async {
    serviceList = await adminService.fetchService(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return staffs == null && serviceList == null
        ? const Loader()
        : Scaffold(
            drawer: Navbar(),
            appBar: AppBar(
              title: Text('Total Care'),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: staffList!.length,
                        itemBuilder: (context, index) {
                          var staffData = staffList![index];
                          return Container(
                              height: 80,
                              width: 300,
                              margin: const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: unselectedItemColor)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage(staffData.image[0]),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Hello Everyone\,',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        staffData.name,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        staffData.profession,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  )
                                ],
                              ));
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const Text(
                    'Our Available Services',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: serviceList!.length,
                      itemBuilder: (context, index) {
                        var data = serviceList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Reservation.reservationPage,arguments: data);
                          },
                          child: Cards(
                              text: data.serviceName,
                              price: 'Rs ${data.price.toString()}',
                              image: data.image),
                        );
                      })
                ],
              ),
            )),
          );
  }
}
