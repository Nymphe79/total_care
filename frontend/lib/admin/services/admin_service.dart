import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:totalcare/admin/screens/bottom_navi.dart';
import 'package:totalcare/constant/error_handling.dart';
import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/constant/show_snackbar.dart';
import 'package:totalcare/home/screens/home_page.dart';
import 'package:totalcare/models/services.dart';
import 'package:totalcare/provider/member_provider.dart';

class AdminService {
  addService(
      {required BuildContext context,
      required String serviceName,
      required List<File> image,
      required double price}) async {
    try {
      final memProv =
          Provider.of<MemberProvider>(context, listen: false).member;
      List<String> imageList = [];
      final cloudinary = CloudinaryPublic('dtp9fxr8d', 'rf0w81h4');
      for (int i = 0; i < image.length; i++) {
        var result = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(image[i].path, folder: serviceName));
        imageList.add(result.secureUrl);
      }

      Service services = Service(

          id: '',
          
           serviceName: serviceName, price: price, image: imageList);

      http.Response res = await http.post(Uri.parse('$uri/admin/add_service'),
          body: services.toJson(),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': memProv.token
          });

      errorHandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, 'New Service is added!');
            Navigator.pushNamed(context, AdminBottomNavi.adminBottom);
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Service>> fetchService(BuildContext context) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false).member;
    List<Service> serviceList = [];

    try {
      http.Response res = await http.get(Uri.parse('$uri/admin/getService'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': memProv.token
          });

      for (int i = 0; i < jsonDecode(res.body).length; i++) {
        serviceList.add(Service.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      // print(e.toString());
    }
    return serviceList;
  }
}
