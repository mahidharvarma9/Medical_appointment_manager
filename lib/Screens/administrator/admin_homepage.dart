//import 'dart:html';


import 'package:flutter/material.dart';
import 'package:leso/Screens/Showapp/show_app.dart';
import 'package:leso/Screens/Showapp/waiting_queue.dart';
import 'package:leso/Success/success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../Date/date.dart';
import '../Login/components/background.dart';
import '../variables.dart';
import '../Signup/signup_screen.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../book/Book.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
import '../book/Book.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'date_limit.dart';


var delay = 0;
String password;
CollectionReference users = FirebaseFirestore.instance.collection('user');
User currentFirebaseUser = FirebaseAuth.instance.currentUser;
TextEditingController emailController = new TextEditingController();


class AdminBody extends StatefulWidget {
  @override
  _AdminBodyState createState() => _AdminBodyState();
}

class _AdminBodyState extends State<AdminBody> {

  signOut() async {
    print("signout..");
    final prefs4 = await SharedPreferences.getInstance();
    prefs4.setString('email', 'empty');
    print("signout.."+FirebaseAuth.instance.currentUser.email);
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
  // const AdminBody({
  //   Key key,
  // }) : super(key: key);
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _onBackPressed,
    child: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              color: Colors.transparent,
              width: double.infinity,
              height: 60,
            ),


            RoundedButton(
              color: button,
              text: "Next Appointment",

              press: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Alert "),
                    content: Text("Are You Sure to Remove the Current Appointment!!"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          HttpClient()
                              .getUrl(Uri.parse(
                              'http://us-central1-first-outlet-307908.cloudfunctions.net/fun_caller?name=' +
                                  FirebaseAuth.instance.currentUser.email +
                                  "|" +
                                  DateTime.now().toString() +
                                  "|" +
                                  Departmant +
                                  "|" +
                                  "3"))
                              .then((request) => request.close()) // sends the request
                              .then((response) => response
                              .transform(Utf8Decoder())
                              .listen(print)); // transforms and prints the response
                          print(DateTime.now().toString());
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
            RoundedButton(
              color: button,
              text: 'Push to Waiting queue',

              press: () async {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Alert "),
                    content: Text("Are You Sure to Push To Waiting Queue!!"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          pushWaitingq();
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


                //Send to API
              },
            ),
            RoundedButton(
              color: button,
              text: "Show Appointments",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AppointmentPage();
                      //return AddUser("dd", "d", 19);
                    },
                  ),
                );

              },
            ),
            RoundedButton(
              color: button,
              text: "Show Waiting Queue",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AppointmentPage_waitingQ();
                      //return AddUser("dd", "d", 19);
                    },
                  ),
                );

              },
            ),
            RoundedButton(
              color: button,
              text: "Change Limit",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DateLimit();
                      //return AddUser("dd", "d", 19);
                    },
                  ),
                );

              },
            ),
            SizedBox(height: size.height * 0.005),
            RoundedButton(
              color: Colors.red,
              text: "Logout",
              press: () async {
                signOut();

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return MyApp();
                //     },
                //   ),
                // );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MyApp(),
                  ),
                      (route) => false,
                );

              },
            ),



          ],
        ),
      ),
    ),
    );
  }
}



