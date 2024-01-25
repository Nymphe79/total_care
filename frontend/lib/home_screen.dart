import 'package:flutter/material.dart';


import 'package:totalcare/constant/global_variables.dart';

import 'home/screens/login_screen.dart';


class HomeScreen extends StatefulWidget {
  static const String home = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> animationed;
  late AnimationController animationController;
  

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation =
        Tween<double>(begin: 0.0, end: 1.1).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          FadeTransition(
            opacity: animation,
            child: Container(
                padding: const EdgeInsets.all(10),
                height: size.height,
                child:
                     Image.asset(
                        'assets/images/logo.jpeg',
                      )),
          ),
          Positioned(
            child: FadeTransition(
                opacity: animation,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: ' Welcome\n ',
                            style: TextStyle(
                                color: backgroundColor,
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0)),
                        TextSpan(
                            text: '       To \n',
                            style: TextStyle(
                                color: backgroundColor,
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0)),
                      ])),
                      const SizedBox(height: 10,),

                       Align(
                                  heightFactor: 8,
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                          return const LoginPage();
                                        }));
                                      },
                                      child: Text('Tap Here!',
                                          style: TextStyle(
                          color: clickColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0)),
                                    ),
                                  ),
                      
                      
                    ],
                  ),
                )),
          ),
          
        ],
      )),
    );
  }
}
