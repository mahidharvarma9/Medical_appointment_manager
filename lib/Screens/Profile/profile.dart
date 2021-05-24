import 'dart:core';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:leso/Screens/Profile/run_profile.dart';
import 'package:leso/Screens/administrator/admin_homepage.dart';
import 'package:leso/components/rounded_button.dart';
import 'package:leso/components/text_field_container.dart';

import '../../constants.dart';


Uint8List uploadedImage;

//method to load image and update `uploadedImage`


enum SingingCharacter { lafayette, jefferson }
final databaseReference = FirebaseFirestore.instance;

class FormScreenState extends State<FormScreen> {

  TextEditingController emailController = new TextEditingController();
  String _name;
  String _gender;
  String _age;
  String _phoneNumber;

  String dropdown;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFieldContainer(child: TextFormField(
      decoration: InputDecoration(

        hintText: 'Name',
        border: InputBorder.none,

      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    )
    );
  }

  Widget _buildPhoneNumber() {
    return TextFieldContainer(child: TextFormField(
      decoration: InputDecoration(

        hintText: 'Phone number',
        border: InputBorder.none,

      ),

      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    )
    );
  }

  Widget gender() {
    return TextFieldContainer(child: TextFormField(
        decoration: InputDecoration(

          hintText: 'Gender',
          border: InputBorder.none,

        ),

        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Gender is required';
          }
          return null;
        },
        onSaved: (String value) {
          _gender = value;
        }
    ),
    );
  }

  Widget age() {
    return  TextFieldContainer(child:TextFormField(
      decoration: InputDecoration(

        hintText: 'Age',
        border: InputBorder.none,

      ),

      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Age is required';
        }




        return null;
      },
      onSaved: (String value) {
        _age = value;
      },
    ),
    );
  }


  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Enter Your Details",style:TextStyle(color: Colors.black),),backgroundColor: Colors.yellow.shade50,),
      body:  SingleChildScrollView(
        child: Center(child: Container(
          width: size.width,

          decoration: BoxDecoration(
            image: DecorationImage(

              image: AssetImage("assets/drop.jpg"),
              fit: BoxFit.cover,
            ),
          ),


          child: Form(

            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildPhoneNumber(),
               age(),
                gender(),

                RoundedButton(

                  text:'Submit',

                  color: Colors.green,
                  press: () async {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Alert "),
                        content: Text("Are You Sure to Submit Your Profile"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {

                              if (!_formKey.currentState.validate()) {
                                return;
                              }

                              _formKey.currentState.save();
                              Map<String, String> contact = {
                                'name': _name,
                                'number': _phoneNumber,
                                'age': _age,
                                'gender':_gender,
                                'email' :currentFirebaseUser.email
                              };
                              flag=1;
                              FirebaseFirestore.instance
                                  .collection('UserDetails').doc(FirebaseAuth.instance.currentUser.email).set(contact);
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

              ],
            ),
          ),
        ),
        ),

      ),

    );
  }
}
