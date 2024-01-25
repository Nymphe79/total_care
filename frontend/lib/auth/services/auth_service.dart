import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalcare/auth/screens/user_login_register.dart';
import 'package:totalcare/constant/error_handling.dart';
import 'package:totalcare/constant/show_snackbar.dart';
import 'package:totalcare/constant/global_variables.dart';

import 'package:totalcare/home/bottom_navi_page.dart';

import 'package:totalcare/models/member.dart';

import 'package:totalcare/provider/member_provider.dart';

class AuthService {
  signup(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required int mobile,
      // required List image,
      required String image}) async {
    try {
      final cloudinary = CloudinaryPublic('dtp9fxr8d', 'rf0w81h4');
      // List<String> imageUrl = [];

      // for (int i = 0; i < image.length; i++) {
      //   var result = await cloudinary
      //       .uploadFile(CloudinaryFile.fromFile(image[i].path, folder: name));
      //   imageUrl.add(result.secureUrl);
      // }

      String imageUrl = '';

      CloudinaryResponse response = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image, folder: name));
     imageUrl = response.secureUrl;

      Member member = Member(
          id: '',
          name: name,
          email: email,
          address: '',
          mobile: mobile,
          password: password,
          type: '',
          token: '',
          image: imageUrl);
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: member.toJson(),
          headers: {'Content-Type': 'application/json;charset=UTF-8'});

      errorHandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account is created!Login as Credentials.');
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  signin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {'Content-Type': 'application/json;charset=UTF-8'});

      errorHandling(
          context: context,
          onSuccess: () async {
            final prefs = await SharedPreferences.getInstance();
            Provider.of<MemberProvider>(context, listen: false)
                .setMember(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamed(context, BottomNavi.bottomNavi);

            print(res.body);
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // post member data

  getMemberData({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      await prefs.setString('x-auth-token', '');
    }

    http.Response tokenRes = await http.post(Uri.parse('$uri/istokenValid'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': token!
        });

    var response = jsonDecode(tokenRes.body);

    if (response == true) {
      http.Response res = await http.get(Uri.parse('$uri/get/memberData'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': token
          });
      Provider.of<MemberProvider>(context, listen: false).setMember(res.body);
    }
  }

  Future<List<Member>> fetchStaffData(BuildContext context) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false).member;
    List<Member> staffList = [];
    try {
      http.Response res = await http.get(Uri.parse('$uri/fetch/staffData'),
          headers: {
            'x-auth-token': memProv.token,
            'Content-Type': 'application/json;charset=UTF-8'
          });

      errorHandling(
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              staffList
                  .add(Member.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return staffList;
  }

  void logout(BuildContext context) async {
    // we have save the user token in local device using shared preferences.
    // so we need to remove that token to log out.

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, Login.authScreen, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update member

  edit(
      {required BuildContext context,
      required String name,
      required int mobile,
      required String image}) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false);

    final cloudinary = CloudinaryPublic('dtp9fxr8d', 'rf0w81h4');
    String imageurl ;

    try {
      CloudinaryResponse response = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image, folder: name));
     imageurl = response.secureUrl;
      
      http.Response res = await http.patch(
          Uri.parse('$uri/edit/profile/:${memProv.member.id}'),
          body: jsonEncode({'name': name, 'mobile': mobile, 'image': imageurl}),
          headers: {
            'x-auth-token': memProv.member.token,
            'Content-Type': 'application/json;charset=UTF-8'
          });

      errorHandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Your Profile has been updated.');
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Member>> fetchMember(BuildContext context) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false);
    List<Member> memList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/fetch/memeber/:${memProv.member.id}'), headers: {
        'x-auth-token': memProv.member.token,
        'Content-Type': 'application/json;charset=UTF-8'
      });

      errorHandling(
          context: context,
          onSuccess: () {
            memList.add(Member.fromJson(jsonEncode(jsonDecode(res.body))));
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return memList;
  }
}
