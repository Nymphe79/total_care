import 'package:flutter/material.dart';
import 'package:totalcare/Staff/screens/staff_home_page.dart';
import 'package:totalcare/Staff/screens/add_staff.dart';
import 'package:totalcare/admin/screens/bottom_navi.dart';
import 'package:totalcare/appoinment/screens/reservation.dart';

import 'package:totalcare/auth/screens/user_login_register.dart';
import 'package:totalcare/home/bottom_navi_page.dart';

import 'package:totalcare/home/screens/home_page.dart';
import 'package:totalcare/models/services.dart';

Route<RouteSettings> router(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Login.authScreen:
      return MaterialPageRoute(builder: (_) {
        return const Login();
      });

    case StaffLoginRegisterPage.staffLoginRegister:
      return MaterialPageRoute(builder: (_) {
        return const StaffLoginRegisterPage();
      });

    case HomePage.page:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const HomePage();
          });

    case StaffHomePage.staffHome:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const StaffHomePage();
          });

    case BottomNavi.bottomNavi:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const BottomNavi();
          });

    case AdminBottomNavi.adminBottom:
      return MaterialPageRoute(builder: (_) {
        return const AdminBottomNavi();
      });

    case Reservation.reservationPage:
      var service = routeSettings.arguments as Service;

      return MaterialPageRoute(builder: (_) {
        return Reservation(
          service: service,
        );
      });

    default:
      return MaterialPageRoute(builder: (_) {
        return const Center(
          child: Text('No Screens'),
        );
      });
  }
}
