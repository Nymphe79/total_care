import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:totalcare/constant/error_handling.dart';
import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/constant/show_snackbar.dart';
import 'package:totalcare/home/screens/home_page.dart';
import 'package:totalcare/models/staff.dart';
import 'package:http/http.dart' as http;
import 'package:totalcare/provider/member_provider.dart';

class StaffService {
  signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String profession,
      required int mobile,
      required List<File> image}) async {
    try {
      final cloudinary = CloudinaryPublic('dtp9fxr8d', 'rf0w81h4');
      List<String> imageUrl = [];

      for (int i = 0; i < image.length; i++) {
        var result = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image[i].path, folder: name));
        imageUrl.add(result.secureUrl);
      }

      Staff staff = Staff(
          id: '',
          type: '',
          name: name,
          image: imageUrl,
          email: email,
          profession: profession,
          mobile: mobile);

      http.Response res = await http.post(Uri.parse('$uri/staff/signup'),
          body: staff.toJson(),
          headers: {'Content-Type': 'application/json;charset=UTF-8'});

      errorHandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, 'New Staff is Register!Login as credentials');
            Navigator.pushNamed(context, HomePage.page);
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Staff>> fetchStaff(BuildContext context) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false).member;

    List<Staff>? staffList = [];

    try {
      http.Response res = await http.get(Uri.parse('$uri/staff/data'),
          headers: {
            'x-auth-token': memProv.token,
            'Content-Type': 'application/json;charset=UTF-8'
          });

      errorHandling(
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              staffList
                  .add(Staff.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return staffList;
  }
}
