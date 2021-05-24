import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants.dart';
import '../admin_dep.dart';
import 'harsh_ready_q.dart';

const IconData domain_verification =
IconData(0xe6ce, fontFamily: 'MaterialIcons');

class Push2RQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 0,
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0))),

          // title: Text(
          //   "leso",
          //   style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 25),
          // ),

          backgroundColor: kPrimaryColor,
          // bottom: TabBar(
          //   tabs:[
          //     Tab(icon:Icon(Icons.home),text:"Home"),
          //     Tab(icon:Icon(Icons.domain_verification),text:"Bookings"),
          //     Tab(icon:Icon(Icons.face),text:"Profile"),
          //   ],
          // ),
        ),
      ),
      body: Wait_Q(),
    ),
  );
}
