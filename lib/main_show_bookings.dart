import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leso/Screens/Date/date.dart';
import 'package:leso/Screens/Login/login_screen.dart';
import 'package:leso/constants.dart';
import 'package:leso/Screens/Login/select_type.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppointmentPage());
}

final db = FirebaseFirestore.instance;

class AppointmentPage extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<AppointmentPage> {
  final List<String> items = ["1", "2", "Third", "4"];
  final presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

  Widget build(BuildContext context) {
    final title = 'Long List';

    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('current_doc')
                    .snapshots(),
                builder: (BuildContext context1,
                    AsyncSnapshot<QuerySnapshot> snapshot1) {
                  if (!snapshot1.hasData) return Text('Loading...');
                  List<QueryDocumentSnapshot> document11 = snapshot1.data.docs;
                  print('size of snapshot current doc:  ' +
                      snapshot1.data.docs.length.toString());
                  snapshot1.data.docs.forEach((doc) {
                    print("printing.....");
                    print("curr_doc...");
                    curr_doc = doc['curr_doc'];
                    print(curr_doc);
                  });

                  int postition = 0;
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc('p1@gmail.com')
                        .collection('appointments')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return Text('Loading...');
                      print('size of snapshot appointments:  ' +
                          snapshot.data.docs.length.toString());
                      List<QueryDocumentSnapshot> items22 = snapshot.data.docs;
                      final int messageCount = snapshot.data.docs.length;
                      print("curr_doc...");
                      print(curr_doc);

                      return ListView.builder(
                        itemCount: messageCount,
                        itemBuilder: (context, position) {
                          // snapshot.data.documents[index]['name'];
                          // document['userRef'] exists here
                          var dept = snapshot.data.docs
                              .elementAt(position)
                              .data()['dep']
                              .toString();
                          print('element at position dep:  ' + dept);

                          var date7 = snapshot.data.docs
                              .elementAt(position)
                              .data()['date']
                              .toString();

                          print('element at position date:  ' + date7);
                          var d = new DateTime.now();
                          var curr_day = d.day + presum[d.month - 1];
                          print('Current date:  ' + curr_day.toString());
                          var index = ((int.parse(date7) -
                                      curr_day +
                                      int.parse(curr_doc)) %
                                  7)
                              .toString();
                          print('index:  ' + index.toString());
                          print('department:  ' + dept);
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(dept)
                                .doc(index)
                                .collection('patients')
                                .where("name", isEqualTo: 'p1@gmail.com')
                                .snapshots(),
                            builder: (BuildContext context1,
                                AsyncSnapshot<QuerySnapshot> snapshot3) {
                              if (!snapshot1.hasData) return Text('Loading...');
                              print('size of snapshot patients:  ' +
                                  snapshot3.data.docs.length.toString());
                              // List<QueryDocumentSnapshot> document11 =
                              //     snapshot3.data.docs;

                              snapshot3.data.docs.forEach((doc) {
                                print("printing.....");
                                print("Queue_num...");
                                queue_num = doc['index'].toString();
                                print(queue_num);
                              });
                              var booking_date;
                              for (var i = 0; i < 12; i++) {
                                if (int.parse(date7) - presum[i] < 0) {
                                  var t1 = int.parse(date7) - presum[i - 1];
                                  booking_date = t1.toString() +
                                      '-' +
                                      (i).toString() +
                                      '-' +
                                      '2021';
                                  break;
                                }
                              }

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text("Department: " +
                                          dept +
                                          "\nDate:" +
                                          booking_date +
                                          "\nQueue Number:  " +
                                          queue_num ??
                                      '<No message retrieved>'),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                })
        )
    );
  }
}
