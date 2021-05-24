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

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });

    await db.collection('current_doc').doc('currId').get()
        .then(function (docRef) {
            uniqueId = parseInt(docRef.data().Id);
            console.log("Current ID: ", uniqueId);
        })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });


    var d = new Date();
    var curr_day = d.getDate() + parseInt(presum[d.getMonth()]);

    console.log('current_doc no:  ' + current_doc);
    console.log(booked_day);
    console.log(curr_day);
    console.log(s);


    if ((booked_day - curr_day + parseInt(current_doc)) % 7 == 0) {
        console.log("in ifff");

        await db.collection('current_doc').doc('currId').set({ 'Id': (uniqueId + 1).toString() })
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });

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


        var patient_no = 'patient_' + (currNum + 1).toString();

        await db.collection(dl).doc('7').collection('patients').doc('total').set({ 'tot': (currNum + 1).toString() })
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });


        await db.collection(dl).doc('7').collection('patients').doc(patient_no).set(data)
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

        await db.collection('current_doc').doc('currId').set({ 'Id': (uniqueId + 1).toString() }).then(function (docRef) {

        }).catch(function (error) {
            console.error("Error adding document: ", error);
        });

        console.log('check timestamp' + admin.firestore.Timestamp.now());

        const data = {
            "patient_id": (uniqueId + 1).toString(),
            "name": email,
            "createdAt": admin.firestore.Timestamp.now()
        };
        console.log('data before adding' + JSON.stringify(data));
        var index = booking.toString();

        var currNum;

        await db.collection(dl).doc(index).collection('patients').doc('total').get()
            .then(function (docRef) {

                currNum = parseInt(docRef.data().tot);
                console.log("currNum: " + currNum);
                console.log('outside undefined:  ');
            })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });


        var patient_no = 'patient_' + (currNum + 1).toString();

        await db.collection(dl).doc(index).collection('patients').doc('total').set({ 'tot': (currNum + 1).toString() })
            .then(function (docRef) {

            }).catch(function (error) {
                console.error("Error adding document: ", error);
            });


        await db.collection(dl).doc(index).collection('patients').doc(patient_no).set(data).then(function (docRef) {
            console.log('Added document: ' + JSON.stringify(docRef));
        })
            .catch(function (error) {
                console.error("Error adding document: ", error);
            });

    }

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

    await db.collection('current_doc').doc('currId').get()
        .then(function (docRef) {
            uniqueId = parseInt(docRef.data().Id);
            console.log("Current ID: ", uniqueId);
        })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });
    // first element of document ordered by timestamp
    console.log("dep: " + dl);
    console.log("curr_doc: " + current_doc);
    console.log("dep: " + dl);
    //General Surgery/2 / patients
    //var path1 = '/' + dl + current_doc + '/patients'
    //var collectionLast = admin.firestore()//.ref(path1).orderByChild('createdAt').limit(1);
    // var collec1 = db.collection(dl).doc(current_doc).collection('patients');
    // var collectionLast = collec1.orderByChild('createdAt').limit(1);
    // console.log(collectionLast);

    var path2 = dl + '/' + current_doc + '/' + 'patients';
    var ref = db.collection(path2);
    // ref.orderBy("createdAt").limit(1).delete().then(() => {
    //     console.log("Document successfully deleted!");
    // }).catch((error) => {
    //     console.error("Error removing document: ", error);
    // });
    var collectionLast = ref.orderBy("createdAt").limit(1);
    collectionLast.get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            doc.ref.delete();
        });
    });
    // collectionLast.once('value', function (snapshot) {
    //     var updates = {};
    //     snapshot.forEach(function (child) {
    //         updates[child.key] = null
    //     });
    //     return ref.update(updates);
    // });
    //var citiesRef = db.collection("cities");

    // citiesRef.doc("SF").set({
    //     name: "San Francisco", state: "CA", country: "USA",
    //     capital: false, population: 860000,
    //     regions: ["west_coast", "norcal"]
    // });
    // citiesRef.doc("LA").set({
    //     name: "Los Angeles", state: "CA", country: "USA",
    //     capital: false, population: 3900000,
    //     regions: ["west_coast", "socal"]
    // });
    // citiesRef.doc("DC").set({
    //     name: "Washington, D.C.", state: null, country: "USA",
    //     capital: true, population: 680000,
    //     regions: ["east_coast"]
    // });
    // citiesRef.doc("TOK").set({
    //     name: "Tokyo", state: null, country: "Japan",
    //     capital: true, population: 9000000,
    //     regions: ["kanto", "honshu"]
    // });
    // citiesRef.doc("BJ").set({
    //     name: "Beijing", state: null, country: "China",
    //     capital: true, population: 21500000,
    //     regions: ["jingjinji", "hebei"]
    // });
    // console.log(citiesRef.orderBy("population", "asc").limit(1));
    // console.log(citiesRef.where("country", "==", "USA").orderBy("population", "asc").limit(1));

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
    var index = booking.toString();
    // const noteRef = await db.collection(dl).doc(index).collection('patients')
    // const doc = await noteRef.where(name, '==', str).get();
    // doc.forEach(element => {
    //     element.ref.delete();
    //     console.log(`deleted: ${element.id}`);
    // });
    var path2 = dl + '/' + index + '/' + 'patients';
    var ref = db.collection(path2);
    // ref.orderBy("createdAt").limit(1).delete().then(() => {
    //     console.log("Document successfully deleted!");
    // }).catch((error) => {
    //     console.error("Error removing document: ", error);
    // });
    var collectionLast = ref.orderBy("createdAt").limit(1);
    collectionLast.get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            doc.ref.delete();
        });
    });
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

    await db.collection('current_doc').doc('doc_id').get()
        .then(function (docRef) {
            current_doc = docRef.data().curr_doc;
            console.log('Current Doc: ' + current_doc);
        })
        .catch(function (error) {
            console.error('Error adding document: ' + error);
        });

    await db.collection('current_doc').doc('currId').get()
        .then(function (docRef) {
            uniqueId = parseInt(docRef.data().Id);
            console.log("Current ID: ", uniqueId);
        })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });
    // first element of document ordered by timestamp

    var collection = db.collection(dl).doc(current_doc).collection('patients');
    var collectionLast = collection.orderByChild('createdAt');
    console.log(collectionLast);
    context.send(collectionLast.toString());

    return;
}
//exports.showAppointment = functions.https.onRequest((req, res) => showAppointment(req, res))


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

    await db.collection('current_doc').doc('currId').get()
        .then(function (docRef) {
            uniqueId = parseInt(docRef.data().Id);
            console.log("Current ID: ", uniqueId);
        })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });
    // first element of document ordered by timestamp

    var collection = db.collection(dl).doc(current_doc).collection('patients');
    var collectionLast = collection.orderByChild('createdAt').limit(1);
    console.log(collectionLast);
    collectionLast.once('value', function (snapshot) {
        var updates = {};
        snapshot.forEach(function (child) {
            updates[child.key] = null
        });
        return ref.update(updates);
    });
    const data = {
        "patient_id": collectionLast.patient_id.toString(),
        "name": collectionLast.email.toString(),
        "createdAt": admin.firestore.Timestamp.now()
    };
    await db.collection(waiting_queue).doc().doc(collectionLast.patient_id.toString()).set(data).then(function (docRef) {
        console.log('Added document: ' + JSON.stringify(collectionLast));
    })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });
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
    res.sendStatus(200);

});


setInterval(() => { }, 1000);