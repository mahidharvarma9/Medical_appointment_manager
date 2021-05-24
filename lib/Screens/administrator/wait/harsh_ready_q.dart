
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:leso/Screens/Login/components/admin_body.dart';
import 'package:leso/Screens/book/Book.dart';
import 'package:leso/Success/success.dart';
import 'package:leso/components/rounded_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../admin_homepage.dart';


class Wait_Q extends StatefulWidget {
  Wait_Q({Key key}) : super(key: key);

  @override
  _Wait_QState createState() => _Wait_QState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _Wait_QState extends State<Wait_Q> {
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
              press: () async {
                var url =
                Uri.parse(

                    'http://us-central1-first-outlet-307908.cloudfunctions.net/fun_caller?name=' +
                        email +
                        "|" +
                        DateTime.now().toString() +
                        "|" +
                        Departmant +
                        "|" +
                        "6");
                // Await the http get response, then decode the json-formatted response.
                var response = await http.post(url, headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                  body: jsonEncode(<String, String>{
                    'title': emailController.text,
                  }),);
                if (response.statusCode == 200) {
                  var jsonResponse = convert.jsonDecode(response.body);
                  var itemCount = jsonResponse['totalItems'];
                  print('Number of books about http: $itemCount.');
                } else {
                  print('Request failed with status: ${response.statusCode}.');
                }


                //Send to API

                Navigator.pushReplacement(
                  context, MaterialPageRoute(
                  builder: (context) {
                    return Book();
                  },
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
