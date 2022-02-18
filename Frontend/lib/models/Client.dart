import 'package:cloud_firestore/cloud_firestore.dart';

final data_network = FirebaseFirestore.instance.collection('data_network').withConverter<Client>(
  fromFirestore: (snapshot, _) => Client.fromJson(snapshot.data()!),
  toFirestore: (client, _) => client.toJson(),
);
final CollectionReference collectionData =
FirebaseFirestore.instance.collection("data_network");

class Client {
  Client({required this.mac, required this.rssi,required this.ssid,
    required this.username, required this.apName, required this.nearNameAP,
    required this.nearRSSIAP});

  Client.fromJson(Map<String, Object?> json)
      : this(
    mac: json['MAC']! as String,
    rssi: json['RSSI']! as String,
    ssid: json['SSID']! as String,
    username: json['Username']! as String,
    apName: json['apName']! as String,
    nearNameAP: json['nearNameAP']! as String,
    nearRSSIAP: json['nearRSSIAP']! as String
  );

  final String mac;
  final String rssi;
  final String ssid;
  final String username;
  final String apName;
  final String nearNameAP;
  final String nearRSSIAP;

  Map<String, Object?> toJson() {
    return {
      'MAC': mac,
      'RSSI': rssi,
      'SSID': ssid,
      'Username': username,
      'apName': apName,
      'nearNameAP': nearNameAP,
      'nearRSSIAP': nearRSSIAP

    };
  }
  String getNet(){
    return apName;
}

}