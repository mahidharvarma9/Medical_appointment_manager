import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leso/Screens/administrator/move2readyqueue/R_Layout.dart';
import 'package:leso/Screens/cancel/layout.dart';
import 'package:leso/components/text_field_container.dart';



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';



class Details_ extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<Details_> {
  //var now = new DateTime.now();
  final List<String> items = ["1", "2", "Third", "4"];

  //final List<String> items=[];

  //MyApp({Key key, @required this.items}) : super(key: key);

  //@override
  Widget build(BuildContext context) {
    final title = 'Patient Details...';



    print(",,,,,,,,,");
    print(name);
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),

            ),
            body:Column(
              children: [
                Text("Patient Details..."),
                TextFieldContainer(
                child:Text("Name:$name")
                  ),
                TextFieldContainer(
                child:
                Text("Age:$age")
                ),
                TextFieldContainer(
                child:Text("Gender:$gender")
                ),
              TextFieldContainer(
              child:
                Text("Phone Number:$number")
    ),

            ],
            )




            
        ));
  }
}