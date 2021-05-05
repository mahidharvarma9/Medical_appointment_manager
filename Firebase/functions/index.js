const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

class Queue {
    constructor() {
        this.items = [];
    }

    // add element to the queue
    enqueue(element) {
        return this.items.push(element);
    }

    // remove element from the queue
    dequeue() {
        if (this.items.length > 0) {
            return this.items.shift();
        }
    }

    delete(ind) {
        return this.items.splice(ind, 1);
    }

    // view the last element
    peek() {
        return this.items[this.items.length - 1];
    }

    // check if the queue is empty
    isEmpty() {
        return this.items.length == 0;
    }

    // the size of the queue
    size() {
        return this.items.length;
    }

    // empty the queue
    clear() {
        this.items = [];
    }
}
var dept = { 'One': 0, 'General Surgery': 1, 'Dermatology,Venereology and leprology': 2, 'Gynaecology': 3, 'Internal Medicine': 4, 'Obstetrics(For Pregnant Women)': 5, 'Ophthalmology(EYE)': 6, 'Oral Health Sciences Center(Dental)': 7, 'Orthopaedics': 8, 'Paediatrics Orthopaedics': 9, 'Paediatric Surgery': 10, 'Paediatric Medicine': 11, 'Plastic Surgery': 12, 'Urology': 13 };

var presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
var department = new Array(13);
var days = new Array();
var i, j;
for (i = 0; i < 365; i++) {

    var department = new Array(13);
    for (j = 0; j < 13; j++) {
        department[j] = new Queue();


    }
    days.push(department);
}

function scheduleAppointment(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    var month = "";
    var control = parseInt(s.split('|')[3]);
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Date = parseInt(str);
    var qq = Date + parseInt(presum[months]);
    if (control == 1) {
        days[parseInt(qq)][parseInt(dept[dl])].enqueue(email);
        console.log([parseInt(qq)]);
        console.log(parseInt(dept[dl]));
        console.log(days[parseInt(qq)][parseInt(dept[dl])].items);
        context.send(200);
    }

    else if (control == 2) {
        var lenss = 0;

        var keys = Object.keys(days[parseInt(qq)][parseInt(dept[dl])]);
        console.log(days[parseInt(qq)][parseInt(dept[dl])].items);
        for (var i = 0, len = keys.length; i < len; i++) {
            lenss += days[parseInt(qq)][parseInt(dept[dl])][keys[i]].length

        }
        context.send(lenss.toString());
    }
    else if (control == 3) {
        var flag = 0;
        var pos = 0;
        var keys = Object.keys(days[parseInt(qq)][parseInt(dept[dl])]);
        console.log(days[parseInt(qq)][parseInt(dept[dl])].items);
        for (var i = 0, len = keys.length; (i < len) && (flag == 0); i++) {

            console.log(days[parseInt(qq)][parseInt(dept[dl])][keys[i]][j]);


            for (var j = 0, lent9 = days[parseInt(qq)][parseInt(dept[dl])][keys[i]].length; j < lent9; j++) {
                pos++;

                if (days[parseInt(qq)][parseInt(dept[dl])][keys[i]][j] == email) {
                    flag = 1;
                    break;

                }

            }
        }
        context.send(pos.toString());
    }

    //pop
    else if (control == 4) {
        var keys = Object.keys(days[parseInt(qq)][parseInt(dept[dl])]);
        var popvalue = days[parseInt(qq)][parseInt(dept[dl])].delete(0);
        console.log("Popped value: " + popvalue);
        context.sendStatus(200);

    }

    //delay
    else if (control == 5) {
        var delay = parseInt(s.split('|')[4]);
        console.log("Delay Value:");
        console.log(delay);
        context.send(delay.toString());
    }

    //cancel appointment

    else if (control == 6) {

        var flag = 0;
        var pos = 0;
        var keys = Object.keys(days[parseInt(qq)][parseInt(dept[dl])]);
        console.log(days[parseInt(qq)][parseInt(dept[dl])].items);
        for (var i = 0, len = keys.length; (i < len) && (flag == 0); i++) {

            console.log(days[parseInt(qq)][parseInt(dept[dl])][keys[i]][j]);


            for (var j = 0, lent9 = days[parseInt(qq)][parseInt(dept[dl])][keys[i]].length; j < lent9; j++) {
                pos++;

                if (days[parseInt(qq)][parseInt(dept[dl])][keys[i]][j] == email) {
                    var delvalue = days[parseInt(qq)][parseInt(dept[dl])].delete(j);
                    console.log("Deleted value: " + delvalue);
                    flag = 1;
                    break;

                }

            }
        }
        context.sendStatus(200);

    }

    else if (control == 7) {
        console.log(days[parseInt(qq)][parseInt(dept[dl])].items);
        context.sendStatus(200);
    }


};


exports.date = functions.https.onRequest((req, res) => scheduleAppointment(req, res))

function schedule(snap, context) {

    const newValue = snap.query.name;
    queue_card.dequeue();
    console.log(queue_card.items);
    context.send(newValue);

};


function getindex(snap, context) {
    var s = snap.query.name;
    var email = s.split('|')[0];
    var dl = s.split('|')[2];
    var str = "";
    str = str + s[email.length + 9] + s[email.length + 10];
    var month = "";
    month = month + s[email.length + 6] + s[email.length + 7];
    var months = parseInt(month);
    var Date = parseInt(str);
    var qq = Date + parseInt(presum[months]);
    days[parseInt(qq)][parseInt(dept[dl])].enqueue(email);
    console.log([parseInt(qq)]);
    console.log(parseInt(dept[dl]));
    console.log(days[parseInt(qq)][parseInt(dept[dl])].items);
    context.send("karan");


};
exports.getpos = functions.https.onRequest((req, res) => getindex(req, res))


/*
while(1){

    while(!isEmpty(days[day][department])){

    //currently executing queue

    }
    day++;

}
*/

setInterval(() => { }, 1000);
