import 'package:flutter/material.dart';
import 'package:totalcare/Staff/screens/add_staff.dart';
import 'package:totalcare/auth/screens/user_login_register.dart';
import 'package:totalcare/constant/global_variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Login Page',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: 'Total ',
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      color: backgroundColor)),
              TextSpan(
                  text: 'Care\n',
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      color: backgroundColor)),
              TextSpan(
                  text: 'Dental ',
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      color: backgroundColor)),
              TextSpan(
                  text: 'Clinic',
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      color: backgroundColor)),
            ])),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, StaffLoginRegisterPage.staffLoginRegister);
              },
              child: const Center(
                child: Text('Staff'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                Text(
                  'or',
                  style: TextStyle(fontSize: 15, color: unselectedItemColor),
                ),
                Expanded(child: Divider())
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Login.authScreen);
                },
                child: Center(
                  child: Text(' User'),
                )),
          ],
        ),
      ),
    ));
  }
}
