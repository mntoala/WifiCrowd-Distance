import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distanciapp/database/Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:distanciapp/constants/colors.dart';
import 'package:overlay_support/overlay_support.dart';

class nearbyU extends StatefulWidget {
  const nearbyU({Key? key}) : super(key: key);
  @override
  _nearbyU createState() => _nearbyU();
}

class _nearbyU extends State<nearbyU> {
  // late final FirebaseMessaging _messaging;
  // PushNotification? _notificationInfo;

  String _imageBackground = "bg2.jpg";
  dynamic dato = [];
  dynamic datoToShow = [];
  dynamic data = [];
  dynamic dataToShow = [];

  Future<dynamic> getDataDN() async {
    final CollectionReference document = db.collection("data_network_prueba");
    final QuerySnapshot information = await document.get();
    final modifyData = information.docs.map((element) {
      return element.data();
    });
    setState(() {
      dato = modifyData;
      datoToShow = modifyData;
    });
  }

  Future<dynamic> getDataHD() async {
    final CollectionReference document = db.collection("history_distance_prueba");
    final QuerySnapshot information = await document.get();
    final modifyData = information.docs.map((element) {
      return element.data();
    });
    setState(() {
      data = modifyData;
      dataToShow = modifyData;
    });
  }

  @override
  void initState() {
    getDataDN();
    getDataHD();

   /* // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
      });
    });

    // Call here
    checkForInitialMessage();*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('holaa');
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
          "Alerts History",
          style: TextStyle(color: AppColors.text_light),
        ),
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
        child: _bod(),
      ),
    );
  }

  Widget _bod() {
    return Container(
      child: Column(
        children: [
          Expanded(flex: 1, child: _topSection()),
          Expanded(
            flex: 2,
            child: _body(),
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
              image: AssetImage('assets/images/social-icon.png'), height: 60,
              alignment: Alignment.center,
            )
        )
      ],
    );
  }

  Widget _body() {
    return datoToShow.length == 0 ? Text('Loading') :
    ListView(
        children: datoToShow.map<Widget>((element) {
          print("////////");
          print(element);
          print(element['data'][0]['Username']);
          print("////////");
          if (element['data']?.length > 0) {
            final String Mac = element['data'][0]['MAC'];
            final String Username = element['data'][0]['Username'];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(8.0),
              child: ExpansionTile(
                backgroundColor: Colors.white,
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person_rounded, color: Colors.black),
                      Text(
                        Username,
                        style: TextStyle(fontSize: 22,
                            fontWeight: FontWeight.w500),),
                    ],),),
                children: <Widget>[
                  historial(Mac),
                  // ListView(shrinkWrap: true,
                  // children: [Text('holaa')],),
                ],),
            );
          }
          return Card();
        }).toList()
    );
  }

  Widget historial(String m) {
    return dataToShow.length == 0 ? Text(''):
    ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: dataToShow.map<Widget>((element) {
          int n=0;
          List<String> days = [];
          List<String> times = [];
          List<double> distancia = [];
          List<String> users = [];
          List<String> macs = [];
          print("AQUI ESTOYY"+m);
          print(element['mac']);
          print(element['mac']==m);
          print(element['history']?.length);
          //print(element);
          for (var i = 0; i < element['history']?.length; i++) {
            String d= (element['history'][i]['date']).toDate().toString();
            double distance=element['history'][i]['distance'];
            String user= element['history'][i]['username'];
            String mac=element['history'][i]['mac'];
            String day= d.substring(0,10);
            String time= d.substring(11,16);
            print('JEJEJE '+ day+ "hora " + time);
            macs.add(mac);
            users.add(user);
            distancia.add(distance);
            days.add(day);
            times.add(time);
          print(days);}
          if (m==element['mac']!) {
            String User= element['username'];
            String mac1=element['mac'];
            print("------"+User);
            print(users);
            print(mac1);
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10.0),
              child: ExpansionTile(
                backgroundColor: Colors.white,
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Alerts History",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),],),),
                children: <Widget>[
                  for (var i = 0; i < users.length; ++i)
                    ListTile(
                      title: Container( child: Text("Date: "+days[i]+"\nHour: "+times[i]+"\n",
                          style: TextStyle(
                              color: AppColors.text_light,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),),
                      subtitle: Container( child: Text("Distancing Breached with "+users[i]+" \n\n"+"Distance: "+distancia[i].toString()+" m.\n",
                          style: TextStyle(
                              color: AppColors.text_light,
                              fontSize: 14)),),
                    ),
                ], ),
            );
          }/*if ((macs.contains(m)==false) && (n == 0)) {
            n=1;
            return ExpansionTile(
              backgroundColor: Colors.white,
              title: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Alerts History",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  ],),),
              children: <Widget>[
                ListTile(
                  title: Container(child:
                  Text('No recent Alerts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.text_light,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),),

                ),
              ],
            );}*/
          /*if (m!=element['mac']!) {
            return Text(
              "No more alerts..",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),);}*/
          return Card();
        }).toList()
    );
  }

  Widget _compa(String m) {
    return dataToShow.length == 0 ? Text('Loading') :
        Container(
       child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            children: <Widget>[
              Text(
                "Alerts History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            ],),),
        children: <Widget>[
            ListTile(
              title: Container(child:
              Text('No recent Alerts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.text_light,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),),

            ),
        ],
      ),);
  }
  /*Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }
  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    // Add the following line
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        setState(() {
          _notificationInfo = notification;
        });

      });
    } else {
      print('User declined or has not accepted permission');
    }
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // ...
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }

  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
      });
    }
  }*/


}


/*
class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}*/
