import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Screens/book/Book.dart';
import '../Details/dd.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
//import 'package:cashfree_pg/cashfree_pg.dart';

import 'package:uuid/uuid.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


CollectionReference users = FirebaseFirestore.instance.collection('user');
void addUser() {

  User currentFirebaseUser = FirebaseAuth.instance.currentUser;


  HttpClient()
      .getUrl(Uri.parse(
      'https://us-central1-first-outlet-307908.cloudfunctions.net/fun_caller?name=' +
          currentFirebaseUser.email +
          "|" +
          Date +
          "|" +
          Departmant +
          "|" +
          "1"))
      .then((request) => request.close()) // sends the request
      .then((response) => response.transform(Utf8Decoder()).listen((data) {
    var resname = data;
    Position= data ;
    print(Position);
  }));
}

