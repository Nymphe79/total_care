import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:totalcare/admin/screens/bottom_navi.dart';
import 'package:totalcare/admin/services/admin_service.dart';
import 'package:totalcare/auth/services/auth_service.dart';
import 'package:totalcare/home/bottom_navi_page.dart';



import 'package:totalcare/home_screen.dart';


import 'package:totalcare/provider/member_provider.dart';
import 'package:totalcare/provider/theme_provider.dart';

import 'package:totalcare/route.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => MemberProvider(),
      ),

      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),


     
     
     
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    AuthService().getMemberData(context: context);
    AdminService().fetchService(context);
   
  }

  Locale? _locale;

  void setLocal(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
        onGenerateRoute: (settings) => router(settings),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).currentTheme,
        home: Provider.of<MemberProvider>(context).member.token.isNotEmpty
            ? Provider.of<MemberProvider>(context).member.type == 'admin'
                ? const AdminBottomNavi()
                : const BottomNavi()
            : const HomeScreen());

            // : const MyWidget());
  }
}
