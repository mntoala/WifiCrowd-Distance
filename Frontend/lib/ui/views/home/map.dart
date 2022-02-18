import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distanciapp/database/Database.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:distanciapp/constants/colors.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);
  @override
  _Maps createState() => _Maps();
}

class _Maps extends State<Maps> {
  ScrollController _controller = ScrollController();
  dynamic data = [];
  dynamic dataToShow = [];
  Future<dynamic> getData() async {
    final CollectionReference document = db.collection("user_position");
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
  // String escenary = 'assets/images/DomoCTI1.png';
  String escenary = 'assets/images/domoEs.png';

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('AQUIII');
    print(data);
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
          "View Map",
          style: TextStyle(color: AppColors.text_light),
        ), //centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white54.withOpacity(0.55), BlendMode.lighten),
              image: AssetImage("assets/images/" + _imageBackground),
              fit: BoxFit.fitHeight),
        ),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          Expanded(flex: 1, child: _topDetail()),
          //child: _profileContent(),
        ],
      ),
    );
  }

  Widget _topDetail() {
    double _size = 10;
    return ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Building CTI ESPOL",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
        ),

        buttonMap(),
        _bod(),

      ],
    );
  }

  Widget buttonMap() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Color.fromRGBO(1, 8, 12, 1.0))),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(10),
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.lightBlue,
                      ),
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                    ),
                    mapaPri(),
                    Positioned(
                        top: -80,
                        child: Icon(Icons.supervisor_account_rounded, size: 100, color: Colors.white)
                    )
                  ],
                )
            )
          );
        },
        padding: EdgeInsets.all(10.0),
        color: Color.fromRGBO(0, 160, 227, 1),
        textColor: Colors.black,
        child: Text("View Map",
            textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget mapaPri() {
    List<String> macs = ["34:13:e8:34:af:1c","a6:70:56:90:08:26",'ac:29:3a:9e:d7:8f',
      'ac:67:b2:3d:62:80', 'd0:31:69:5a:1a:49'];
    return Container(
      height: 470,
      alignment: Alignment.center,
      child:
      Column(
        children: [
          Text('BUILDING MAP \n',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Stack(
            children: <Widget>[
              Image.asset(escenary),
              //oPos(0.1,-0.15, 'ivaleriano')
              for (var i = 0; i < macs.length; ++i)
                _otPos(macs[i]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bmap() {
    return dataToShow.length == 0
        ? Text('Loading')
        : ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: dataToShow.map<Widget>((element) {
              List<String> users = [];
              List<double> distancia = [];
              List<String> macss = [];
              for (var i = 0; i < element['nearby']?.length; i++) {
                String date = element['nearby'][i]['username'];
                double d = element['nearby'][i]['distancia'];
                String macc = element['nearby'][i]['mac'];
                macss.add(macc);
                distancia.add(d);
                users.add(date);
              }
              if (element['nearby']?.length > 0) {
                String User = element['Username'];
                String mac1 = element['MAC'];
                print("------" + User);
                print(users);
                print(mac1);
                print(macss);
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10.0),
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    title: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.person_rounded, color: Colors.red),
                          Text(
                            User,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      for (var i = 0; i < users.length; ++i)
                        ListTile(
                          title: Container(
                            child: Text(users[i],
                                style: TextStyle(
                                    color: AppColors.text_light,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          subtitle: Container(
                            child: Text(
                                "Distance: " + distancia[i].toString() + " m.",
                                style: TextStyle(
                                    color: AppColors.text_light, fontSize: 14)),
                          ),
                        ),
                      mapss(mac1, macss),
                    ],
                  ),
                );
              }

              return Card();
            }).toList());
  }

  Widget mapss(String mac1, List<String> macss) {
    return Container(
      height: 450,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Image.asset(escenary),
          _upPos(mac1),
          for (var i = 0; i < macss.length; ++i)
            _otPos(macss[i]),
        ],
      ),
    );
  }

  Widget uPos(double x, double y, String user) {
    return Container(
      height: 401,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Align(
          alignment: Alignment(x, y),
          child: iconRed(user),
        ),
      ),
    );
  }

  Widget oPos(double x, double y, String user) {
    return Container(
      height: 401,
      //alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Align(
          alignment: Alignment(x, y),
          child: iconBlack(user),
        ),
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> _upPos(String m) {
    return FutureBuilder<Map<String, dynamic>>(
      future: Database().infPos(m),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        //print(snapshot);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return uPos(0, 0, 'Username');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return uPos(0, 0, 'Username');
          }
          if (snapshot.data == null) {
            return uPos(0, 0, 'Username');
          }
          if (snapshot.data!['MAC'] == m) {
            double y = -((snapshot.data!['coory'] / 20) - 0.06);
            double x = ((snapshot.data!['coorx'] / 20) - 0.12);
            print(snapshot.data!['coorx']);
            print(snapshot.data!['coory']);
            print(x);
            print(y);
            return uPos(x, y, snapshot.data!['Username']);
          }
        }
        return uPos(0, 0, 'Username');
      },
    );
  }

  FutureBuilder<Map<String, dynamic>> _otPos(String m) {
    return FutureBuilder<Map<String, dynamic>>(
      future: Database().infPos(m),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        //print(snapshot);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return oPos(0, 0, 'Username');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return oPos(0, 0, 'Username');
          }
          if (snapshot.data == null) {
            return oPos(0, 0, 'Username');
          }
          if (snapshot.data!['MAC'] == m) {
            double y = -((snapshot.data!['coory'] / 20) - 0.06);
            double x = ((snapshot.data!['coorx'] / 20) - 0.12);
            print(snapshot.data!['coorx']);
            print(snapshot.data!['coory']);
            print(x);
            print(y);
            return oPos(x, y, snapshot.data!['Username']);
          }
        }
        return oPos(0, 0, 'Ronaldo');
      },
    );
  }

  Widget _bod() {
    return dataToShow.length == 0
        ? Text('Loading')
        : ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: dataToShow.map<Widget>((element) {
              List<String> users = [];
              List<double> distancia = [];
              List<String> macss = [];
              for (var i = 0; i < element['nearby']?.length; i++) {
                String date = element['nearby'][i]['username'];
                double d = element['nearby'][i]['distancia'];
                String macc = element['nearby'][i]['mac'];
                macss.add(macc);
                distancia.add(d);
                users.add(date);
              }
              if (element['nearby']?.length > 0) {
                String User = element['Username'];
                String mac1 = element['MAC'];
                print("------" + User);
                print(users);
                print(mac1);
                print(macss);
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10.0),
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    title: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.person_rounded, color: Colors.red),
                          Text(
                            User,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      for (var i = 0; i < users.length; ++i)
                        ListTile(
                          title: Container(
                            child: Text(users[i],
                                style: TextStyle(
                                    color: AppColors.text_light,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          subtitle: Container(
                            child: Text(
                                "Distance: " + distancia[i].toString() + " m.",
                                style: TextStyle(
                                    color: AppColors.text_light, fontSize: 14)),
                          ),
                        ),
                      //mapss(mac1, macss),
                    ],
                  ),
                );
              }

              return Card();
            }).toList());
  }

  Widget iconRed(String user) {
    return IconButton(
      icon: Icon(Icons.person_rounded, size: 30, color: Colors.red),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(children: <Widget>[
              Icon(Icons.person_rounded, color: Colors.red),
              Text("  Username:",
                  style: TextStyle(
                      color: AppColors.text_light,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
            content: Text(user,
                style: TextStyle(color: AppColors.text_light, fontSize: 18)),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget iconBlack(String user) {
    return IconButton(
      icon: Icon(Icons.person_rounded, size: 30, color: Colors.black),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(children: <Widget>[
              Icon(Icons.person_rounded, color: Colors.black),
              Text("  Username:",
                  style: TextStyle(
                      color: AppColors.text_light,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
            content: Text(user,
                style: TextStyle(color: AppColors.text_light, fontSize: 18)),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class Usericon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.person_rounded, size: 30, color: Colors.black),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(children: <Widget>[
              Icon(Icons.person_rounded, color: Colors.purple),
              Text("  Username:",
                  style: TextStyle(
                      color: AppColors.text_light,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
            content: Text("user",
                style: TextStyle(color: AppColors.text_light, fontSize: 18)),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class FormStr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Text("    ",
            style: TextStyle(
                color: AppColors.text_light,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Icon(Icons.person_rounded, color: Colors.red),
        Text("  marina.toala",
            style: TextStyle(
                color: AppColors.text_light,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        //Text("Hello"),
      ]),
    );
  }
}
