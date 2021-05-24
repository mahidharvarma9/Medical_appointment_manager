import 'package:flutter/material.dart';
import 'package:leso/Screens/Profile/Form.dart';
import 'package:leso/Screens/administrator/date_limit.dart';
import 'package:leso/Screens/cancel/layout.dart';
import 'package:leso/components/text_field_container.dart';
import '../administrator/admin_homepage.dart';
import '../Profile/profile.dart';
import 'package:leso/Screens/book/components/body.dart';

import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
const IconData domain_verification =
IconData(0xe6ce, fontFamily: 'MaterialIcons');
var booking_date;
var curr_doc;
var queue_time;
var queue_num,email_id;
getCurrDoc() async {
  await FirebaseFirestore.instance
      .collection('current_doc')
      .doc('doc_id')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    print('Document data: ${documentSnapshot.data()["curr_doc"]}');
    current_doc = int.parse(documentSnapshot.data()["curr_doc"]);
  });
  print("%%%%%%%");
  print(current_doc);
}
final presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
class WaitingQlist extends StatelessWidget {

  @override

  Widget build(BuildContext context){



    return  StreamBuilder(

                stream: FirebaseFirestore.instance
                    .collection('current_doc')
                    .snapshots(),
                builder: (BuildContext context1,
                    AsyncSnapshot<QuerySnapshot> snapshot1) {
                  if (!snapshot1.hasData) return Text('Loading...');
                  //List<QueryDocumentSnapshot> document11 = snapshot1.data.docs;
                  //final int messageCount = snapshot1.data.docs.length;
                  //curr_doc=document11['curr_doc'];
                  if(snapshot1.data == null) return CircularProgressIndicator();
                  print("Current user:   ");
                  print(currentFirebaseUser.email);
                  snapshot1.data.docs.forEach((doc) {
                    print("printing.....");
                    print("curr_doc...");
                    curr_doc = doc['curr_doc'];
                    print(curr_doc);
                  });
                  print("email"+currentFirebaseUser.email);

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
                      if(snapshot.data == null) return CircularProgressIndicator();
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
                          var email_id = snapshot.data.docs
                              .elementAt(position)
                              .data()['name']
                              .toString();

                          print('element at position dep:  ' + email_id);

                          var date7 = snapshot.data.docs
                              .elementAt(position)
                              .data()['date'];
                          var date75 = snapshot.data.docs
                              .elementAt(position)
                              .data()['date_'];

                          print('element at position date:  ' + date7.toString());
                          var d = new DateTime.now();
                          var curr_day = d.day + presum[d.month - 1];
                          print('Current date:  ' + curr_day.toString());
                          print(int.parse(curr_doc));
                          var index = ((date7 -
                              curr_day +
                              int.parse(curr_doc)) %
                              7)
                              .toString();

                          print('index:  ' + index);
                          print('department:  ' + email_id);


                              return  ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TextFieldContainer(child: GestureDetector(


                                      child: Center(child:  Text("Department: " +
                                          email_id +
                                          "\nDate:" +
                                         booking_date +
                                          "\nQueue Number:  " +
                                          queue_num ??
                                          '<No message retrieved>'),),
                                      onTap: () =>
                                      {
                                      Departmant =email_id,
                                      Date = date75,
                                    Position=queue_num,
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  cancel())),
                                      }
                                  ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => const Divider(),

                              );
                            },
                          );
                        },


                  );
                }
                );


  }
}
