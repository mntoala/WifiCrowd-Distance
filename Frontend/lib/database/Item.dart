import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distanciapp/database/Database.dart';
import 'package:flutter/material.dart';
final String net = "";
class Item extends StatelessWidget {
  final String dato1;
  final String dato2;
  final String valor;
  Item(this.dato1,this.dato2,this.valor);
  @override
  Widget build(BuildContext context) {
    CollectionReference data_network = db.collection('data_network');
    return FutureBuilder<DocumentSnapshot>(
      future: data_network.doc('ac:29:3a:9e:d7:8f').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            children: [
              FormItem(text: dato1,label: "E-mail",
                hintText: "Enter your mail",),
              FormItem(text: dato2,hintText: "Nombre",
                label: "Username",),
              FormItem(text: data[valor] ,label: "Network", hintText:
              "Network",),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
class FormItem extends StatelessWidget {
  final String? text;
  final String? label;
  final String? hintText;
  const FormItem({
    Key? key,
    this.text,
    this.label,
    this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        key: ValueKey(text),
        enabled: false,
        controller: TextEditingController(text: text),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_rounded),
            labelText: label,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0,
                20.0, 15.0),
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0))),
      ),
    );
  }

}