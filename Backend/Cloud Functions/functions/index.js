const functions = require('firebase-functions');
const express = require('express');
const admin = require('firebase-admin');
const app = express();

const serviceAccount = require("./key.json");
const { event } = require('firebase-functions/lib/providers/analytics');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    // here goes the file with credentials from firebase console
    databaseURL: "https://distanciapp-default-rtdb.firebaseio.com"
});

const registrationToken = 'e4VYgM7MSx-MDYqPQKeVTn:APA91bES1BK2TXIlg4nnv-bm5nPXI5WbMclX-8jcRW7xwbtk1tRL1gIaFII-9V7Pnf3iN_jINK7q1XR1va3JcJ77RzKlDxHZ6YNU65pQbJKJiwr9X2XnMjQoROUh9sNvdIQRBfXt-hBG';

//trigger
//.add(-1)
//var tokens = [];
var newData;

// push notifications application
exports.messageTrigger = functions.firestore.document('history_distance_prueba/{Id}').onUpdate(async (snapshot, context) => {
    if(snapshot.empty) {
        return;
    }
   
    newData = snapshot.data;
    
    console.log(newData);
    
    var payload = {
        notification: {
             title: 'Broken Social Distancing!', 
             body: `mntoala and patricio.mendoza have broken the distance.\nDistance: 1.4 m.`, 
             sound: 'default'
         },
         data : {
             //click_action: 'FLUTTER_NOTIFICATION_CLICK',
            //  message: `${newData.username} y  ${newData.history} has been broken distancing. Date: ${newData.historydate}.`
             message: `Broken Social Distancing!`
         },
         //token: registrationToken
     }

    var options = { priority: 'high', timeToLive: 60*60*34, };

    // //buscar sendToall ${newData.username} and ${newData.history}  
     try {
         const response = await admin.messaging().sendToDevice(registrationToken, payload, options);
         console.log('mensaje enviado');
    } catch (error) {
         console.log('error');
     }
});
