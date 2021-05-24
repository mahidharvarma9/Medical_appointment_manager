import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../administrator/admin_homepage.dart';
import '../../Department/department.dart';
import '../../Login/components/background.dart';
import '../../../main.dart';
import '../../Signup/signup_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String email;
String password;


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // const Body({
  //   Key key,
  // }) : super(key: key);
  signOut() async {
    print("signout..");

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

  @override
  Widget build(BuildContext context)  {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 80.0),
                color: Colors.transparent,
                width: double.infinity,
                height: 60,
              ),
              RoundedButton(
                color: button,
                text: "Book Appointment",

                press: () {
                  print(FirebaseAuth.instance.currentUser.email);
                  if(flag==1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyStatefulWidget();
                        },
                      ),
                    );
                  }
                  else{
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Alert "),
                        content: Text("Please create your Profile first"),
                        actions: <Widget>[

                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();

                            },

                            child: Text("Okay"),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: size.height * 0.03),
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
              Container(
                color: Colors.transparent,
                width: double.infinity,
                height: 60,
                child: FlatButton(
                  onPressed: () {},
                  color: Colors.blueGrey,
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }



// class Body extends StatelessWidget {
//   const Body({
//     Key key,
//   }) : super(key: key);
//   Future<bool> _onBackPressed() {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Are you sure?'),
//             content: Text('You are going to exit the application!!'),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('NO'),
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//               ),
//               FlatButton(
//                 child: Text('YES'),
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context)  {
//     Size size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Background(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 margin: const EdgeInsets.only(top: 80.0),
//                 color: Colors.transparent,
//                 width: double.infinity,
//                 height: 60,
//               ),
//               RoundedButton(
//                 color: button,
//                 text: "Book Appointment",
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return MyStatefulWidget();
//                       },
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: size.height * 0.03),
//               RoundedButton(
//                 color: button,
//                 text: "View/Cancel Bookings",
//                 press: () {
//                   HttpClient()
//                       .getUrl(Uri.parse(
//                       'http://us-central1-first-outlet-307908.cloudfunctions.net/fun_caller?name=' +
//                           currentFirebaseUser.email +
//                           "|" +
//                           DateTime.now().toString() +
//                           "|" +
//                           Departmant +
//                           "|" +
//                           "5"))
//                       .then((request) => request.close()) // sends the request
//                       .then((response) => response
//                       .transform(Utf8Decoder())
//                       .listen(print)); // transforms and prints the response
//                 },
//               ),
//               SizedBox(height: size.height * 0.03),
//               RoundedButton(
//                 color: button,
//                 text: "Logout",
//                 press: () async {
//                   await FirebaseAuth.instance.signOut();
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return MyApp();
//                       },
//                     ),
//                   );
//                 },
//               ),
//               Container(
//                 color: Colors.transparent,
//                 width: double.infinity,
//                 height: 60,
//                 child: FlatButton(
//                   onPressed: () {},
//                   color: Colors.blueGrey,
//                   child: Text(
//                     "Contact Us",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 22.0,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
