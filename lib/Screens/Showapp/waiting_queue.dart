import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leso/Screens/administrator/move2readyqueue/R_Layout.dart';
import 'package:leso/Screens/cancel/layout.dart';
import 'package:leso/components/text_field_container.dart';
import '../Date/date.dart';
import '../Login/login_screen.dart';
import '../../constants.dart';
import '../Login/select_type.dart';



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AppointmentPage_waitingQ extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<AppointmentPage_waitingQ> {
  //var now = new DateTime.now();
  final List<String> items = ["1", "2", "Third", "4"];

  //final List<String> items=[];

  //MyApp({Key key, @required this.items}) : super(key: key);

  //@override
  Widget build(BuildContext context) {
    final title = 'Waiting Queue..';
    var curr_doc;
    // var current_doc= FirebaseFirestore.instance
    //             .collection('current_doc')
    //             .doc('doc_id').get().then((QuerySnapshot querySnapshot)=>{
    //               print(docref.docs[0].data["field"])
    //             });
    // FirebaseFirestore.instance
    //     .collection('current_doc')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    // querySnapshot.docs.forEach((doc) {
    //   print("printing.....");

    //     curr_doc = doc['curr_doc'];
    //   });
    // });
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
                  //final int messageCount = snapshot1.data.docs.length;
                  //curr_doc=document11['curr_doc'];
                  snapshot1.data.docs.forEach((doc) {
                    print("printing.....");
                    print("curr_doc...");
                    curr_doc = doc['curr_doc'];
                    print(curr_doc);
                  });
                  //print(items22);
                  //
                  int postition=0;
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(Departmant)
                        .doc(curr_doc)
                        .collection('waiting_queue')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return Text('Loading...');
                      List<QueryDocumentSnapshot> items22 = snapshot.data.docs;
                      final int messageCount = snapshot.data.docs.length;
                      print("curr_doc...");
                      print(curr_doc);
                      print(messageCount);

                      return ListView.builder(
                        itemCount: messageCount,
                        itemBuilder: (context, position) {
                          // snapshot.data.documents[index]['name'];
                          // document['userRef'] exists here
                          // return Card(
                          //
                          //   child: Padding(
                          //
                          //     padding: const EdgeInsets.all(20.0),
                          //     child: Text(snapshot.data.docs.elementAt(position).data()['name'] ??
                          //         '<No message retrieved>'),
                          //
                          //
                          //
                          //
                          //   ),
                          // );

                              return TextFieldContainer(child: GestureDetector(


                                  child: Center(child:  Text(snapshot.data.docs.elementAt(position).data()['name'] ??
                                        '<No message retrieved>'),),
                                  onTap: () =>
                                  {


                                    user_email = snapshot.data.docs.elementAt(position).data()['name'],
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  c_ancel())),

                                  }
                              ),
                              );







                        },
                      );
                    },
                  );
                })
        ));
  }
}