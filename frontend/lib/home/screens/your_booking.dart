import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:totalcare/appoinment/services/appoint_services.dart';
import 'package:totalcare/commons%20widget/loader.dart';
import 'package:totalcare/home/widget/booking_card.dart';
import 'package:totalcare/models/appoinment.dart';

class YourBooking extends StatefulWidget {
  const YourBooking({Key? key}) : super(key: key);

  @override
  State<YourBooking> createState() => _YourBookingState();
}

class _YourBookingState extends State<YourBooking> {
  final appointmentService = AppoimentService();
  List<Appointment>? appoint;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppoint();
  }

  getAppoint() async {
    appoint = await appointmentService.getAppointmentData(context);
    setState(() {});
  }

// here we need to take parameter product bcoz we don't know which product is to be deleted
//obviously the index so that we can delete it from the client side as well
 void  deleteAppoint(Appointment appointment, int index) async {
    await appointmentService.deleteAppointment(
        context: context,
        appoint: appointment,
        onSuccess: () {
          appoint!.removeAt(index);
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return appoint == null
        ? const Loader()
        : Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Your Booking'),
                  const SizedBox(
                    height: 40,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: appoint!.length,
                      itemBuilder: (context, index) {
                        var data = appoint![index];

                        return BookingCard(
                          name: data.name,
                          serviceName: data.title,
                          date: DateFormat('yyyy-mm-dd').format(data.date),
                          time: data.time,
                          onpressed: () {
                            setState(() {
                               deleteAppoint(data, index);
                            });
                           
                          },
                        );
                      })
                ],
              ),
            )),
          );
  }
}
