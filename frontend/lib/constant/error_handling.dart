import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:totalcare/constant/show_snackbar.dart';

errorHandling(
    {required BuildContext context,
    required VoidCallback onSuccess,
    required http.Response response}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;

    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;

    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;

    default:
      showSnackBar(context, response.body);
  }
}
