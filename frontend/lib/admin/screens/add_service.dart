import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:totalcare/admin/services/admin_service.dart';

import '../../commons widget/button.dart';
import '../../commons widget/text_input.dart';
import '../../commons widget/title.dart';
import '../../constant/global_variables.dart';
import '../../constant/utils.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  List<File> image = [];
  final formKey = GlobalKey<FormState>();
  final serviceNameController = TextEditingController();
  final priceController = TextEditingController();
  final adminService = AdminService();

  void selectedImage() async {
    var images = await pickImage();
    setState(() {
      image = images;
    });
  }

  void addServices() async {
    await adminService.addService(
        context: context,
        serviceName: serviceNameController.text,
        image: image,
        price: double.parse(priceController.text));
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
                  title: 'Add Services',
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
                                        borderRadius: BorderRadius.circular(10),
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
                        key: formKey,
                        child: Column(
                          children: [
                            TextInput(
                                text: 'ServiceName',
                                controller: serviceNameController),
                            const SizedBox(
                              height: 10,
                            ),
                            TextInput(
                                text: 'Price', controller: priceController),
                            const SizedBox(
                              height: 20,
                            ),
                            Button(
                                text: 'Add',
                                onTap: () {
                                  if (formKey.currentState!.validate() &&
                                      image.isNotEmpty) {
                                    addServices();
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
