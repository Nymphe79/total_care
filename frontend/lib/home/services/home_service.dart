import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:totalcare/constant/error_handling.dart';
import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/constant/show_snackbar.dart';
import 'package:totalcare/provider/member_provider.dart';

class HomeService {
  sendEmail(BuildContext context) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false).member;

    try {
      http.Response res = await http.post(Uri.parse('$uri/send/mail'),
          body: memProv.email,
          headers: {
            'x-auth-token': memProv.token,
            'Context-Type': 'application/json;charset=UTF-8'
          });

      errorHandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Email has been sent to your email address');
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
