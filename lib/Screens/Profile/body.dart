import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:leso/Screens/administrator/admin_homepage.dart';

import '../../constants.dart';

TextEditingController _nameController, _numberController;
String _typeSelected = '';

CollectionReference _ref;
@override
void initState() {
  // TODO: implement initState
  initState();
  _nameController = TextEditingController();
  _numberController = TextEditingController();
  _ref = FirebaseFirestore.instance
      .collection('Users').doc(FirebaseAuth.instance.currentUser.email).collection("Details");
}

void saveContact() {
  String name = _nameController.text;
  String number = _numberController.text;

  Map<String, String> contact = {
    'name': name,
    'number': '+91 ' + number,
    'type': _typeSelected,
  };

  _ref.add(contact).then((value) {
    print("ffff");
    flag = 1;

  });
}
