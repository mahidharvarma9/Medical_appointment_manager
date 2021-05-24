

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:leso/Screens/Showapp/waiting_queue.dart';
import 'package:leso/Screens/book/Book.dart';
import 'package:leso/Success/success.dart';
import 'package:leso/components/rounded_button.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../admin_homepage.dart';


class MyStateful_Widget extends StatefulWidget {
  MyStateful_Widget({Key key}) : super(key: key);

  @override
  _MyStateful_WidgetState createState() => _MyStateful_WidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStateful_WidgetState extends State<MyStateful_Widget> {
  String dropdownValue = 'One';
  List<String> listValue = <String>[
    'One',
    'General Surgery',
    'Dermatology,Venereology and leprology',
    'Gynaecology',
    'Internal Medicine',
    'Obstetrics(For Pregnant Women)',
    'Ophthalmology(EYE)',
    'Oral Health Sciences Center(Dental)',
    'Orthopaedics',
    'Paediatrics Orthopaedics',
    'Paediatric Surgery',
    'Paediatric Medicine',
    'Plastic Surgery',
    'Urology'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              color: Colors.transparent,
              width: double.infinity,
              height: 10,
            ),
            Align(
                alignment: Alignment.center,
                child:Text(
                  "Name: " + user_email,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
            SizedBox(height: size.height * 0.03),

            RoundedButton(
              color: button,
              text: "Push to Ready Queue ",
              press: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Alert "),
                    content: Text("Are You Sure to Push To Ready Queue"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          moveUser();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AppointmentPage_waitingQ();
                              },
                            ),
                          );
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Confirm"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();

                        },

                        child: Text("No"),
                      )
                    ],
                  ),
                );

              },
            ),
//SizedBox(height: size.height * 0.03),
// RoundedButton(
//   color: button,
//   text: "View/Cancel Bookings",
//   press: () {},
// ),
// Container(
//   color: Colors.transparent,
//   width: double.infinity,
//   height: 60,
//   child: FlatButton(
//     onPressed: () {},
//     color: Colors.blueGrey,
//     child: Text(
//       "Contact Us",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 22.0,
//       ),
//     ),
//   ),
// ),
          ],
        ),
      ),
    );
  }
}
