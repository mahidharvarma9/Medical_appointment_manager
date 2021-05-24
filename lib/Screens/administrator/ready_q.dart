//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:leso/Screens/Login/components/admin_body.dart';

import 'file:///G:/My_apps/leso/lib/Screens/Showapp/show_app.dart';
import '../Date/date.dart';
import '../Login/components/background.dart';
import '../variables.dart';
import '../Signup/signup_screen.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:leso/Screens/administrator/admin_dep.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import 'package:cashfree_pg/cashfree_pg.dart';

import 'package:uuid/uuid.dart';
import 'package:leso/Screens/administrator/admin_homepage.dart';

class pushtoReadyQ extends StatelessWidget {
  const pushtoReadyQ({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body:
    Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: 'email',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedButton(

              text: 'Push to Ready queue',

              color: Colors.blue,
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
              },
            ),
          ],),),));
    throw UnimplementedError();
  }
}
