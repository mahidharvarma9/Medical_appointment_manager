//import 'dart:html';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:leso/components/text_field_container.dart';

import 'date_limit.dart';


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
import 'package:uuid/uuid.dart';
import 'package:leso/Screens/administrator/admin_homepage.dart';

var msg3 = "";
var current_doc;
var current_limit;
var limit;
class limit_change extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return limitDoc();
  }
}


class limitDoc extends State<limit_change>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  getCurrDoc() async {
    await FirebaseFirestore.instance
        .collection('current_doc')
        .doc('doc_id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print('Document data: ${documentSnapshot.data()['curr_doc']}');
      current_doc = int.parse(documentSnapshot.data()['curr_doc']);
    });
    print("%%%%%%%");
    print(current_doc);
  }
  Widget limit_() {
    return  TextFieldContainer(child:TextFormField(
      decoration: InputDecoration(

        hintText: 'limit',
        border: InputBorder.none,

      ),

      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'limit is required';
        }

        return null;
      },

      onSaved: (String value) {
        limit = value;
      },
    ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    msg3=" ";
    return Scaffold(

        body: Background(
          child: SingleChildScrollView(
            child: Form(

                key: _formKey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                SizedBox(height: size.height * 0.03),
                limit_(),
                  // Align(
                  //   alignment: Alignment.center,
                  //   // Align however you like (i.e .centerRight, centerLeft)
                  //   print(msg3+"valueeee");
                  //   child: RichText(
                  //       text: TextSpan(children: <TextSpan>[
                  //         TextSpan(
                  //             text: msg3+"j cdhhj h",
                  //             style: TextStyle(
                  //               color: Colors.green,
                  //             )),
                  //       ])),
                  // ),


                RoundedButton(

                  text: 'Confirm Limit',

                  color: Colors.blue,
                  press: () async {

                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Alert "),
                        content: Text("Are You Sure to change the limit??"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () async {

                                  if (!_formKey.currentState.validate()) {
                                    print('inside return');
                                    return;
                                  }

                                  _formKey.currentState.save();
                                  await getCurrDoc();
                                  var c = currInd_limit.toString();
                                  print(limit);
                                  print('before update');
                                  await FirebaseFirestore.instance.collection(Departmant).doc(c).collection(
                                      'patients').doc('limit').update({
                                    'limit': limit,

                                  }).then((value) {
                                    print("success:  ");



                                  }).catchError((e) {
                                    // errorMessage=e.toString();
                                    print("error:  ");
                                    print(e);
                                    msg3="Error in updating limit";

                                  });

                                  //Send to API
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

                  //   if (!_formKey.currentState.validate()) {
                  //     print('inside return');
                  //     return;
                  //   }
                  //
                  //   _formKey.currentState.save();
                  //   await getCurrDoc();
                  //   var c = currInd_limit.toString();
                  //   print(limit);
                  //   print('before update');
                  //   await FirebaseFirestore.instance.collection(Departmant).doc(c).collection(
                  //       'patients').doc('limit').update({
                  //     'limit': limit,
                  //
                  //   }).then((value) {
                  //     print("success:  ");
                  //
                  //
                  //
                  //   }).catchError((e) {
                  //     // errorMessage=e.toString();
                  //     print("error:  ");
                  //     print(e);
                  //     msg3="Error in updating limit";
                  //
                  //   });
                  //
                  //   setState(() {
                  //     print("inside setstate");
                  //   msg3="Limit updated successfully";});
                  //   print("meg3"+msg3);
                  //   //Send to API
                  // },
                ),





              ]
            ),
          ),
        ))
    );
  }

}
