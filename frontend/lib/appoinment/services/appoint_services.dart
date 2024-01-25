import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalcare/constant/error_handling.dart';
import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/constant/show_snackbar.dart';
import 'package:totalcare/models/appoinment.dart';
import 'package:http/http.dart' as http;

import 'package:totalcare/provider/member_provider.dart';

class AppoimentService {
  makeAppointment(
      {required BuildContext context,
      required String title,
      required String time,
      required DateTime date}) async {
    try {
      final memProv =
          Provider.of<MemberProvider>(context, listen: false).member;
      Appointment appointment = Appointment(
          id: '',
          memberId: '',
          name: '',
          title: title,
          description: '',
          date: date,
          time: time);

      http.Response res = await http.post(Uri.parse('$uri/make/appointment'),
          body: appointment.toJson(),
          headers: {
            'x-auth-token': memProv.token,
            'Content-Type': 'application/json;charset=UTF-8'
          });

      errorHandling(
          context: context,
          onSuccess: () {
            showSnackBar(context, 'You have successfully make an appointment');
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Appointment>> getAppointmentData(BuildContext context) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false).member;

    List<Appointment> appointList = [];

    try {
      http.Response res = await http.get(Uri.parse('$uri/get/appointment/me'),
          headers: {
            'x-auth-token': memProv.token,
            'Content-Type': 'application/json;charset=UTF-8'
          });

      errorHandling(
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              appointList.add(
                  Appointment.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          },
          response: res);

      print(jsonDecode(res.body));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return appointList;
  }

  deleteAppointment(
      {required BuildContext context,
      required Appointment appoint,
      required VoidCallback onSuccess}) async {
    final memProv = Provider.of<MemberProvider>(context, listen: false).member;
    try {
      http.Response res = await http.post(Uri.parse('$uri/delete/appoint'),
          body:jsonEncode({'id':appoint.id}),
          headers: {
            'x-auth-token': memProv.token,
            'Content-Type': 'application/json;charset=UTF-8'
          });

      errorHandling(
          context: context,
          onSuccess: () {
            onSuccess();
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
