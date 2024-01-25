import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totalcare/appoinment/services/appoint_services.dart';
import 'package:totalcare/commons%20widget/button.dart';
import 'package:totalcare/commons%20widget/text_input.dart';
import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/home/bottom_navi_page.dart';

import 'package:totalcare/home/services/home_service.dart';

import 'package:totalcare/models/services.dart';

class Reservation extends StatefulWidget {
  static const String reservationPage = '/reservation';

  final Service service;

  const Reservation({Key? key, required this.service}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  DateTime? picked;

  final appointService = AppoimentService();

  TimeOfDay selectedTime = TimeOfDay.now();

  TimeOfDay? chooseTime;

  final homeService = HomeService();

  Future<void> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030, 12));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    chooseTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        helpText: 'Enter your time & press ok!',
        initialTime: selectedTime);
    if (chooseTime != null && chooseTime != selectedTime) {
      setState(() {
        selectedTime = chooseTime!;
      });
    }
  }

  void makeBooking() async {
    await appointService.makeAppointment(
        context: context,
        title: widget.service.serviceName,
        date: picked!,
        time: chooseTime.toString());
  }

  void sendMail() async {
    await homeService.sendEmail(context);
  }

  @override
  void dispose() {
  
    super.dispose();
    titleController.dispose();
    timeController.dispose();
    dateController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var index = ModalRoute.of(context)!.settings.arguments as Service;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Make Your Appointment',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: buttonColor),
              ),
              const SizedBox(
                height: 70,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: widget.service.serviceName,
                    hintStyle: const TextStyle(color: textColor)),
              ),
              // TextInput(text: 'Title', controller: titleController),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                  text: 'Questions (Optional)', controller: descriptionController),
              const SizedBox(
                height: 10,
              ),
              picked == null
                  ? TextButton.icon(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: buttonColor,
                      ),
                      label: const Text(
                        'Select a date',
                        style: TextStyle(color: textColor, fontSize: 15),
                      ))
                  : TextField(
                      decoration: InputDecoration(
                          hintText: DateFormat.yMMMMd().format(picked!),
                          hintStyle:
                              const TextStyle(fontSize: 20, color: textColor)),
                    ),
              const SizedBox(
                height: 10,
              ),
              chooseTime != null
                  ? InkWell(
                      onTap: () {
                        selectTime(context);
                      },
                      child: Text(
                        'Your Schedule: ${chooseTime!.format(context)}',
                        style: const TextStyle(color: textColor, fontSize: 25),
                      ),
                    )
                  : TextButton.icon(
                      onPressed: () {
                        selectTime(context);
                      },
                      icon: const Icon(
                        Icons.ads_click_outlined,
                        color: buttonColor,
                      ),
                      label: const Text(
                        'Choose your schedule here!',
                        style: TextStyle(color: textColor, fontSize: 15),
                      )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Button(
                    text: 'Book',
                    onTap: () async {
                      if (formKey.currentState!.validate() &&
                          picked != null &&
                          chooseTime != null) {
                        confirmation(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: errorColor,
                                duration: Duration(milliseconds: 300),
                                content: Text(
                                  'Enter & Select all fields',
                                  style: TextStyle(
                                      color: normalColor, fontSize: 20),
                                )));
                      }
                    },
                    color: buttonColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, BottomNavi.bottomNavi);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              )
            ],
          ),
        ),
      )),
    );
  }

  confirmation(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button
        builder: (_) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            backgroundColor: backgroundColor,
            title: const Align(
                alignment: Alignment.center, child: Text('Confirm')),
            titlePadding: const EdgeInsets.all(10),
            content: Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${widget.service.serviceName}'),
                  Text('Question: ${descriptionController.text}'),
                  Text('Date: ${DateFormat.yMMMMd().format(picked!)}'),
                  Text('Time: ${chooseTime!.format(context)}')
                ],
              ),
            ),
            actions: [
              Material(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                      onTap: () {
                        makeBooking();
                        sendMail();
                        Navigator.pushNamed(context, BottomNavi.bottomNavi);
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: normalColor),
                      )),
                ),
              ),
              Material(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: errorColor),
                      )),
                ),
              ),
            ],
          );
        });
  }
}
