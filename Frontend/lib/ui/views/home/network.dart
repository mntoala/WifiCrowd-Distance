import 'package:distanciapp/database/Database.dart';
import 'package:distanciapp/database/Item.dart';
import 'package:flutter/material.dart';
import 'package:distanciapp/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Network extends StatefulWidget {
  const Network({Key? key}) : super(key: key);
  @override
  _Network createState() => _Network();
}
class _Network extends State<Network> {
  dynamic data = [];
  dynamic dataToShow = [];
  Future<dynamic> getData() async {
    final CollectionReference document =  db.collection("data_network_prueba");
    final QuerySnapshot information = await document.get();
    final modifyData = information.docs.map((element) {
      return element.data();
    });

    setState(() {
      data = modifyData;
      dataToShow = modifyData;
    });
  }
  String _imageBackground = "bg2.jpg";
  String m = "ac:29:3a:9e:d7:8f";
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset('assets/images/logoSHORT.png'),
            iconSize: 55,
            onPressed: () => {},
          ),
        ],
        title: Text(
          "Network Data",
          style: TextStyle(color: AppColors.text_light),
        ),//centerTitle: true,
      ),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white54.withOpacity(0.55),
                  BlendMode.lighten),
              image: AssetImage("assets/images/" +
                  _imageBackground),
              fit: BoxFit.fitHeight),


        ),
        //child:
        child:
        //Text(data_network),
        _body(),
      ),
    );
  }
  Widget _body(){
    return Container(
      child: Column(
        children: [
          Expanded(flex: 1, child: _topSection()),
          Expanded(
            flex: 2,
            child: _bd(),
            //_infoRed(),
          ),
        ],
      ),
    );
  }

  Widget _topSection() {
    double _size = 130;
    return ListView(
      children: [
        const SizedBox(
          height: 45,
        ),
        Container(
            width: _size,
            height: _size,
            child: Image(
              image: AssetImage('assets/images/data-net.png'),height: 60,
              alignment: Alignment.center,
            ))
      ],
    );
  }

  Widget _infoRed() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Colors.black.withOpacity(0.05))
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: Column(crossAxisAlignment:
        CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8,
                top: 30,bottom: 30),
            child: Row(
              children: const [
                Text("Network information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.text_light,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),

                Spacer(flex: 1),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8,
                top: 30,bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Txt(),
                Flexible(child: //_Item(),
                _by(),
                ),
              ],
            ),

          ),
        ],),),);
  }
  Widget _bd(){
    return dataToShow.length == 0 ? Text('Loading'):
    ListView(
        children: dataToShow.map<Widget>((element) {
          int v= element['data']?.length;
          print(v);
          if (element['data']?.length > 0) {
            final String Username = element['data'][v-1]['Username'];
            final String apName = element['data'][v-1]['apName'];
            final String SSID = element['data'][v-1]['SSID'];
            final String RSSI = (element['data'][v-1]['RSSI']).toString();
            final String nearNameAP = element['data'][v-1]['nearNameAP'];
            final String nearRSSIAP = (element['data'][v-1]['nearRSSIAP']).toString();
            return Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(
                  Username,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                    title: Container( child: Text("Network information \n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.text_light,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Txt(),
                        Flexible(child: Text("    "+Username+
                            "\n    "+apName+
                            "\n    "+SSID+
                            "\n    "+RSSI+" dBm"+
                            "\n    "+nearNameAP+
                            "\n    "+nearRSSIAP+ "\n",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.text_light,
                                fontSize: 20,
                                height: 1.5)),
                        ),
                      ],
                    ),
                  ),
                ], ),);
          }

          return Card();
        }).toList()
    );
  }
  Widget _by() {
    return dataToShow.length == 0 ? Text('Loading'):
    ListView(
        children: dataToShow.map<Widget>((element) {
          for (var i = 0; i < element['data']?.length; i++) {
            if (element['data']?.length > 0) {
              if (element['last_update'] == element['data'][i]['date']) {
                print(
                    'last update: ${element['last_update']}, Username=${element['data'][i]['Username']}');
                final String Username = element['data'][i]['Username'];
                final String apName = element['data'][i]['apName'];
                final String SSID = element['data'][i]['SSID'];
                final int RSSI = element['data'][i]['RSSI'];
                final String nearNameAP = element['data'][i]['nearNameAP'];
                final int nearRSSIAP = element['data'][i]['nearRSSIAP'];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                        title: Text(Username),
                      ),
                    ],),);
              }

              return Card();
            }}}).toList()
    );
  }
  FutureBuilder<Map<String, dynamic>> _Item() {
    return FutureBuilder<Map<String, dynamic>>(
      future: Database().info('ac:29:3a:9e:d7:8f'),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("    "+"Username"+
              "\n    "+"apName"+
              "\n    "+"SSID"+
              "\n    "+"RSSI"+" dBm"
              "\n    "+"nearNameAP"
              "\n    "+"nearRSSIAP",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.text_light,
                  fontSize: 20,
                  height: 1.5));
        }
        return Text("    "+"${snapshot.data!['Username']}"+
            "\n    "+"${snapshot.data!['apName']}"+
            "\n    "+"${snapshot.data!['SSID']}"+
            "\n    "+"${snapshot.data!['RSSI']}"+" dBm"
            "\n    "+"${snapshot.data!['nearNameAP']}"
            "\n    "+"${snapshot.data!['nearRSSIAP']}",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.text_light,
                fontSize: 20,
                height: 1.5));

      },
    );
  }
  Widget mInfo(String Username, String apName, String SSID, int RSSI, String nearNameAP, int nearRSSIAP){
    return Container(
      child: Text("    "+"Username"+
          "\n    "+"apName"+
          "\n    "+"SSID"+
          "\n    "+"RSSI"+" dBm"
          "\n    "+"nearNameAP"
          "\n    "+"nearRSSIAP",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColors.text_light,
              fontSize: 20,
              height: 1.5)),

    );
  }

  List<Widget> _getChildren(List<String> datos, int nDatos) => List<Widget>.generate(
    nDatos,
        (i) => ListTile(title: Text('$datos[$i]')),
  );


  Widget Txt(){
    return Text("Username:  "
        "\nApName:  "
        "\nSSID:  "
        "\nRSSI:  "
        "\nNear AP:"
        "\nNear AP: \n",
        textAlign: TextAlign.left,
        style: TextStyle(
            color: AppColors.text_light,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.5) );
  }
//[Username, apName, SSID, RSSI.toString(), nearNameAP, nearRSSIAP.toString()],

}