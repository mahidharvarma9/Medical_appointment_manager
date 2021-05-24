const functions = require("firebase-functions");
var admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: 'https://first-outlet-307908.firebaseio.com'
});
const db = admin.firestore();
var firebaseDatabase = admin.firestore();
var dept = { 'One': 0, 'General Surgery': 1, 'Dermatology,Venereology and leprology': 2, 'Gynaecology': 3, 'Internal Medicine': 4, 'Obstetrics(For Pregnant Women)': 5, 'Ophthalmology(EYE)': 6, 'Oral Health Sciences Center(Dental)': 7, 'Orthopaedics': 8, 'Paediatrics Orthopaedics': 9, 'Paediatric Surgery': 10, 'Paediatric Medicine': 11, 'Plastic Surgery': 12, 'Urology': 13 };

var presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

async function scheduleAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var output;
    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });



    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);

    console.log('current_doc no:  ' + current_doc);
    console.log(booked_day);
    console.log(curr_day);
    console.log(s);
    await db.collection('Users').doc(email).collection('appointments').doc().set({ 'dep': dl, 'date': booked_day })
        .then(function (docRef) {

        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });

    if ((booked_day - curr_day + parseInt(current_doc)) % 7 == 0) {
        console.log("in ifff");



        console.log('check timestamp' + admin.firestore.Timestamp.now());
        const data = {
            "patient_id": (uniqueId + 1).toString(),
            "name": email,
            "createdAt": admin.firestore.Timestamp.now()
        };

        console.log('data before adding' + JSON.stringify(data));

        var currNum;

        await db.collection(dl).doc('7').collection('patients').doc('total').get()
            .then(function (docRef) {
                currNum = parseInt(docRef.data().tot);
                console.log("currNum: " + currNum);
            })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });




        var path4 = dl + '/' + index + '/' + 'patients';
        const collectionLast1 = db.collection(path4).doc('total');

        const doc = await collectionLast1.get();
        if (!doc.exists) {
            console.log('No such document!');
        } else {
            console.log('Document data:', doc.data());
        }
        current_d1 = doc.data();
        collectionLast1.update({ "tot": (current_d1["tot"] + 1) }).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(docRef));
        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });


        output = current_d1["tot"] + 1;
        await db.collection(dl).doc('7').collection('patients').doc().set(data)
            .then(function (docRef) {
                console.log('Patient_id: ' + docRef.patient_id);
                console.log('created at' + "  " + docRef.createdAt);
            })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });

    }
    else {

        var booking = (booked_day - curr_day + parseInt(current_doc)) % 7;



        console.log('check timestamp' + admin.firestore.Timestamp.now());

        const data = {
            "patient_id": (uniqueId + 1).toString(),
            "name": email,
            "createdAt": admin.firestore.Timestamp.now()
        };
        console.log('data before adding' + JSON.stringify(data));
        var index = booking.toString();







        var path4 = dl + '/' + index + '/' + 'patients';
        const collectionLast1 = db.collection(path4).doc('total');

        const doc = await collectionLast1.get();
        if (!doc.exists) {
            console.log('No such document!');
        } else {
            console.log('Document data:', doc.data());
        }
        current_d1 = doc.data();
        collectionLast1.update({ "tot": (current_d1["tot"] + 1) }).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(docRef));
        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });

        output = current_d1["tot"] + 1;

        await db.collection(dl).doc(index).collection('patients').doc().set(data).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(docRef));
        })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });

    }
    context.send(output.toString());
    return;


}

//exports.scheduleAppointment = functions.https.onRequest((req, res) => scheduleAppointment(req, res))


async function popAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });


    // first element of document ordered by timestamp
    console.log("dep: " + dl);
    console.log("curr_doc: " + current_doc);
    console.log("dep: " + dl);


    var path2 = dl + '/' + current_doc + '/' + 'patients';
    var ref = db.collection(path2);

    var del_time;
    var collec2;
    var collectionLast = ref.orderBy("createdAt").limit(1);
    collectionLast.get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            console.log('$$');
            console.log(JSON.stringify(doc.data()));
            del_time = doc.data().createdAt;
            doc.ref.delete();
            collec2 = ref.where("createdAt", '>', del_time);
            collec2.get().then(function (querySnapshot) {
                console.log('##');
                console.log(JSON.stringify(doc.data()));
                querySnapshot.forEach(function (doc) {
                    console.log('%%');
                    var curr_index = doc.data().index;
                    console.log('current_index:  ' + curr_index);
                    doc.ref.update("index", curr_index - 1);
                })
            });

        });
    });


    var curr_ind1;
    await db.collection(dl).doc(index).collection('patients').doc('curr_ind').get()
        .then(function (docRef) {
            curr_ind1 = docRef.data().index;
            db.collection(dl).doc(index).collection('patients').doc('curr_ind').update({ "index": (curr_ind1 - 1) }).then(function (docRef) {
            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });
        })
        .catch(function (error) {
            console.error("Error index: ", error);
        });


    context.sendStatus(200);
    return;
}

//exports.popAppointment = functions.https.onRequest((req, res) => popAppointment(req, res))


async function cancelAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);
    // search and delete

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });
    if ((booked_day - curr_day + parseInt(current_doc)) % 7 == 0) {
        console.log("in ifff");

        // const noteRef = await db.collection(dl).doc(index).collection('patients')
        // const doc = await noteRef.where(name, '==', str).get();
        // doc.forEach(element => {
        //     element.ref.delete();
        //     console.log(`deleted: ${element.id}`);
        // });
        var path2 = dl + '/7/' + 'patients';
        var ref = db.collection(path2);

        var path4 = dl + '/7/' + 'patients';
        const collectionLast1 = db.collection(path4).doc('total');

        const doc = await collectionLast1.get();
        if (!doc.exists) {
            console.log('No such document!');
        } else {
            console.log('Document data:', doc.data());
        }
        current_d1 = doc.data();
        collectionLast1.update({ "tot": (current_d1["tot"] - 1) }).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(docRef));
        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });
        var path5 = dl + '/' + current_doc + '/' + 'dustbin';
        await db.collection(path5).doc().set({ data: "deleted" }).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(collectionLast));
        })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });

        var collectionLast = ref.where("name", '==', (email.toString()));

        collectionLast.get().then(function (querySnapshot) {
            querySnapshot.forEach(function (doc) {
                doc.ref.delete();
            });
        });

    }
    else {

        var booking = (booked_day - curr_day + parseInt(current_doc)) % 7;

        var index = booking.toString();
        console.log("in else");
        console.log(booked_day);
        console.log(curr_day);
        console.log(email.toString());
        // const noteRef = await db.collection(dl).doc(index).collection('patients')
        // const doc = await noteRef.where(name, '==', str).get();

        var path2 = dl + '/' + index + '/' + 'patients';
        var ref = db.collection(path2);

        // ref.orderBy("createdAt").limit(1).delete().then(() => {
        //     console.log("Document successfully deleted!");
        // }).catch((error) => {
        //     console.error("Error removing document: ", error);
        // });
        const snapshot = await ref.where('name', '==', (email.toString()));
        snapshot.get().then(function (querySnapshot) {
            querySnapshot.forEach(function (doc) {
                doc.ref.delete();
            });
        });
        var path4 = dl + '/' + index + '/' + 'patients';
        const collectionLast1 = db.collection(path4).doc('total');

        const doc = await collectionLast1.get();
        if (!doc.exists) {
            console.log('No such document!');
        } else {
            console.log('Document data:', doc.data());
        }
        current_d1 = doc.data();
        collectionLast1.update({ "tot": (current_d1["tot"] - 1) }).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(docRef));
        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });
        var path5 = dl + '/' + current_doc + '/' + 'dustbin';
        await db.collection(path5).doc().set({ data: "deleted" }).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(collectionLast));
        })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });

    }
    if ((booked_day - curr_day + parseInt(current_doc)) % 7 == 0) booking = 7;
    else booking = (booked_day - curr_day + parseInt(current_doc)) % 7;
    context.sendStatus(200);
    return;
}
//exports.cancelAppointment = functions.https.onRequest((req, res) => cancelAppointment(req, res))


async function showAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);
    // search and delete
    var output = "";
    console.log(booked_day);
    console.log(curr_day);
    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });
    if ((booked_day - curr_day + parseInt(current_doc)) % 7 == 0) {
        console.log("in ifff");

        // const noteRef = await db.collection(dl).doc(index).collection('patients')
        // const doc = await noteRef.where(name, '==', str).get();
        // doc.forEach(element => {
        //     element.ref.delete();
        //     console.log(`deleted: ${element.id}`);
        // });
        var path2 = dl + '/7/' + 'patients';
        var ref = db.collection(path2);

        ref.get().then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                // doc.data() is never undefined for query doc snapshots
                console.log(JSON.stringify(doc.data()));
            });
        });
        console.log(output);
    }
    else {

        var booking = (booked_day - curr_day + parseInt(current_doc)) % 7;

        var index = booking.toString();
        console.log("in else");
        console.log(booked_day);
        console.log(curr_day);
        console.log(email.toString());
        // const noteRef = await db.collection(dl).doc(index).collection('patients')
        // const doc = await noteRef.where(name, '==', str).get();

        var path2 = dl + '/' + current_doc + '/' + 'patients';
        var ref = db.collection(path2);

        ref.get().then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                // doc.data() is never undefined for query doc snapshots
                output = output + JSON.stringify(doc.data());
            });
        });
        console.log(output);
    }
    console.log(output);
    context.send(output);
}
exports.showAppointment = functions.https.onRequest((req, res) => showAppointment(req, res))


async function waiting_queue(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    month = "";
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Dat = parseInt(str);
    var booked_day = Dat + parseInt(presum[months - 1]);
    var uniqueId, current_doc;
    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            uniqueId = parseInt(docRef.data().Id);
            console.log("Current ID: ", uniqueId);
        })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });
    // first element of document ordered by timestamp


    var path2 = dl + '/' + current_doc + '/' + 'patients';
    var ref = db.collection(path2);
    var current_d;


    var collectionLast = ref.orderBy("createdAt").limit(1);
    collectionLast.get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            doc.ref.get().then(async function (docRef) {
                current_d = docRef.data();
                var path3 = dl + '/' + current_doc + '/' + 'waiting_queue';
                await db.collection(path3).doc(current_d["patient_id"]).set(current_d).then(function (docRef) {
                    console.log('Added document: ' + JSON.stringify(collectionLast));
                })
                    .catch(function (error) {
                        console.error("Error adding document: ", error);
                    });

                await doc.ref.delete();

            })
                .catch(function (error) {
                    console.error('Error adding document: ' + error);
                });

        });
    });


    // adding data to waiting queue



    context.sendStatus(200);
    return;
}

exports.fun_caller = functions.https.onRequest((req, res) => {
    var q = req.query.name;
    console.log("request:  " + req);
    console.log("query:   " + q);
    var control = parseInt(q.split('|')[3]);
    console.log("control:   " + control);
    switch (control) {
        case 1:
            scheduleAppointment(req, res);
            break;
        case 2:
            showAppointment(req, res);
            break;
        case 3:
            popAppointment(req, res);
            break;
        case 4:
            waiting_queue(req, res);
            break;
        case 5:
            cancelAppointment(req, res);
            break;

    }


});


setInterval(() => { }, 1000);