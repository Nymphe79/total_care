import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:totalcare/Staff/services/staff_service.dart';
import 'package:totalcare/commons%20widget/button.dart';
import 'package:totalcare/commons%20widget/list_tile.dart';
import 'package:totalcare/commons%20widget/text_input.dart';
import 'package:totalcare/commons%20widget/title.dart';

import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/constant/utils.dart';



class StaffLoginRegisterPage extends StatefulWidget {
  static const String staffLoginRegister = '/staffLoginRegister';
  const StaffLoginRegisterPage({Key? key}) : super(key: key);

  @override
  State<StaffLoginRegisterPage> createState() => _StaffLoginRegisterPageState();
}

class _StaffLoginRegisterPageState extends State<StaffLoginRegisterPage> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final professionController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  List<File> image = [];
  final staffService = StaffService();

  void selectedImage() async {
    var images = await pickImage();
    setState(() {
      image = images;
    });
  }

  void staffSignUp()async{
   await staffService.signUp(
        context: context,
        name: nameController.text,
        email: emailController.text,
       
        profession: professionController.text,
       
        mobile: int.parse(mobileController.text),
        image: image);
  }

  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const CustomTitle(
                  title: 'Add Staff',
                  color: backgroundColor,
                  textAlign: Alignment.center),


                   const SizedBox(
                height: 20,
              ),
            
                Column(
                  children: [
                    image.isNotEmpty
                        ? CarouselSlider(
                            options: CarouselOptions(
                                height: 150,
                                viewportFraction: 1,
                                aspectRatio: 1.0),
                            items: image
                                .map((e) => Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: unselectedItemColor)),
                                      child: Image.file(
                                        e,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                .toList(),
                          )
                        : Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: unselectedItemColor)),
                            child: IconButton(
                                onPressed: () {
                                  selectedImage();
                                },
                                icon: Icon(
                                  Icons.folder,
                                  size: 30,
                                  color: unselectedItemColor,
                                ))),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                          key: signUpFormKey,
                          child: Column(
                            children: [
                              TextInput(
                                  text: 'Name', controller: nameController),
                              const SizedBox(
                                height: 10,
                              ),
                              TextInput(
                                  text: 'Email', controller: emailController),
                              const SizedBox(
                                height: 10,
                              ),
                             
                              TextInput(
                                  text: 'Profession',
                                  controller: professionController),
                              const SizedBox(
                                height: 10,
                              ),
                             
                              TextInput(
                                  text: 'Mobile', controller: mobileController),
                              const SizedBox(
                                height: 20,
                              ),
                              Button(
                                  text: 'Add',
                                  onTap: () {
                                    if (signUpFormKey.currentState!
                                            .validate() &&
                                        image.isNotEmpty) {
                                      staffSignUp();
                                    }
                                  },
                                  color: backgroundColor)
                            ],
                          )),
                    ),
                  ],
                ),
             
                    
                
            ],
          ),
        )),
      ),
    );
  }
}
