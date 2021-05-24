

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:leso/Screens/book/Book.dart';
import '../../Success/success.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Date/date.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../../constants.dart';
import '../confirm_details/confirm_details.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
                  "Department: " + Departmant,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
            SizedBox(height: size.height * 0.03),
            Align(
                alignment: Alignment.center,
                child:Text(
                  "Date: " + Date,
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              color: button,
              text: "Cancel Booking",
              press: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Alert "),
                    content: Text("Are You Sure you want to cancel this appointment??"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          deleteUser();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return Book();
                          //     },
                          //   ),
                          // );
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
