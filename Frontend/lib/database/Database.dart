import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

final FirebaseFirestore db = FirebaseFirestore.instance;
final String mac = "ac:29:3a:9e:d7:8f";

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<String> infoD(String v) async {
    String h;
    DocumentSnapshot snap;
    CollectionReference data_network = db.collection('data_network');
    try {
      snap = await data_network.doc(mac).get();
      if (snap.exists) {
        Map<String, dynamic>? data = snap.data()! as Map<String, dynamic>;
        h = data[v];
        return h;
      } else {
        return mac;
      }
    } catch (e) {
      return 'error';
      //print(e);
    }
  }

  Future<Map<String, dynamic>> info(String m) async {
    DocumentSnapshot snap;
    Map<String, dynamic> nulo = {'apName': 0, 'name': 'Doesn'};
    CollectionReference data_network = db.collection('data_network');
    try {
      snap = await data_network.doc(m).get();
      if (snap.exists) {
        Map<String, dynamic>? data = snap.data()! as Map<String, dynamic>;
        //h=data[v];
        return data;
      } else {
        print("Doesn't exist");
        return nulo;
      }
    } catch (e) {
      //print("no se");
      return nulo;
      //print(e);
    }
  }

  Future<Map<String, dynamic>> infPos(String m) async {
    DocumentSnapshot snap;
    Map<String, dynamic> nulo = {'apName': 0, 'name': 'Doesn'};
    CollectionReference user_position = db.collection('user_position');
    try {
      snap = await user_position.doc(m).get();
      if (snap.exists) {
        Map<String, dynamic>? data = snap.data()! as Map<String, dynamic>;
        //h=data[v];
        return data;
      } else {
        print("Doesn't exist");
        return nulo;
      }
    } catch (e) {
      //print("no se");
      return nulo;
      //print(e);
    }
  }

/*
QuerySnapshot snap = await
    Firestore.instance.collection('collection').getDocuments();

snap.documents.forEach((document) {
    print(document.documentID);
  });
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('collection');

Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
}
 */

}
//AsyncSnapshot<QuerySnapshot> snapshot
