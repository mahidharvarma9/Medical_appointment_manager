

import 'package:flutter/material.dart';
import 'package:leso/Screens/Profile/Form.dart';

import 'package:leso/Screens/cancel/layout.dart';
import 'package:leso/components/text_field_container.dart';


import 'package:leso/Screens/Profile/profile.dart';
import 'package:leso/Screens/administrator/admin_homepage.dart';



import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';
import 'layout.dart';
const IconData domain_verification =
IconData(0xe6ce, fontFamily: 'MaterialIcons');
var booking_date;
var curr_doc;
var queue_time;
var queue_num,dept;

final presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
class Book_wait extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            centerTitle: true,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0))),
            title: Text(
              "leso",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            bottom: TabBar(
              tabs: [

                Tab(
                    icon: Icon(Icons.domain_verification),
                    text: "Bookings"),
                Tab(icon: Icon(Icons.face), text: "Profile"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [

            StreamBuilder(
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




                              var len_ = snapshot.data.docs.length;

                              return  ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: len_,
                                itemBuilder: (BuildContext context, int index) {
                                  return TextFieldContainer(child: GestureDetector(


                                      child: Center(child:  Text("Email: " +
                                          email_id +
                                          "\nDate:" +
                                          date75 ??
                                          '<No message retrieved>'),),
                                      onTap: () =>
                                      {

                                        Date = date75,
                                        Position=queue_num,
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  Push2RQ())),
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
                }),



            FormScreen(),
          ],
        )

    ),
  );
}
