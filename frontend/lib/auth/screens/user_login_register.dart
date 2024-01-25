import 'dart:io';

import 'package:flutter/material.dart';
import 'package:totalcare/auth/services/auth_service.dart';

import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/constant/utils.dart';
import 'package:totalcare/home/bottom_navi_page.dart';

import '../../commons widget/button.dart';
import '../../commons widget/text_input.dart';

enum Auth { signin, signup }

class Login extends StatefulWidget {
  static const String authScreen = '/authscreen';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Auth auth = Auth.signup;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final signUpformkey = GlobalKey<FormState>();
  final signInformkey = GlobalKey<FormState>();
  final authService = AuthService();

  String? image = '';

  // List<File> image = [];

  // void pickedImage() async {
  //   var images = await pickImage();
  //   setState(() {
  //     image = images;
  //   });
  // }


  


  chooseImage() async {
    image = await selectImage();
    setState(() {});
  }

  void signingup() async {
    await authService.signup(
        context: context,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        mobile: int.parse(mobileController.text),
        // image: image);
        image: image!);
  }

  void signingIn() async {
    await authService.signin(
        context: context,
        email: emailController.text,
        password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: normalColor,
        body: SafeArea(
          child: Column(children: [
            Text(
              'User\'s Register & Sign In Page!',
              style: TextStyle(fontSize: 25, color: backgroundColor),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Radio(
                  value: Auth.signup,
                  groupValue: auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      auth = val!;
                    });
                  }),
              title: const Text('Create an Account'),
            ),
            if (auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                    key: signUpformkey,
                    child: Column(
                      children: [
                        //  ClipOval(
                        //         child: InkWell(
                        //             onTap: selectImage,

                        //        child:
                        //        image!.isNotEmpty? Image.file(
                        //               File(image!),
                        //               height: 100,
                        //               width: 100,
                        //               fit: BoxFit.cover,
                        //             )
                        //             :   CircleAvatar(
                        //           radius: 50,
                        //           backgroundImage: AssetImage(
                        //             'assets/images/no image.png',
                        //           ),
                        //         ),
                        //       ),
                        //             ),

                        Stack(
                          children: [
                            ClipOval(
                                child: image!.isNotEmpty
                                    ? Image.file(
                                        File(image!),
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                            'assets/images/no image.png'),
                                      )),
                            Positioned(
                                bottom: -10,
                                right: -5,
                                child: IconButton(
                                    onPressed: () {
                                      chooseImage();
                                    },
                                    icon: Icon(
                                      Icons.photo,
                                      color: unselectedItemColor,
                                      size: 35,
                                    )))
                          ],
                        ),

                        TextInput(text: 'Name', controller: nameController),
                        TextInput(text: 'Email', controller: emailController),
                        TextInput(text: 'Mobile', controller: mobileController),
                        TextInput(
                            text: 'Password', controller: passwordController),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                            text: 'Register',
                            onTap: () {
                              if (signUpformkey.currentState!.validate() &&
                                  image!.isNotEmpty) {
                                signingup();
                              }
                            },
                            color: backgroundColor)
                      ],
                    )),
              ),
            ListTile(
              leading: Radio(
                  value: Auth.signin,
                  groupValue: auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      auth = val!;
                    });
                  }),
              title: const Text('Sign In'),
            ),
            if (auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                    key: signInformkey,
                    child: Column(
                      children: [
                        TextInput(text: 'Email', controller: emailController),
                        TextInput(
                            text: 'Password', controller: passwordController),
                        const SizedBox(
                          height: 20,
                        ),
                        Button(
                            text: 'Sign In',
                            onTap: () {
                              if (signInformkey.currentState!.validate()) {
                                signingIn();
                              }
                            },
                            color: buttonColor)
                      ],
                    )),
              ),
          ]),
        ));
  }
}
