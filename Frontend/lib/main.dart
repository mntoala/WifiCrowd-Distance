import 'package:distanciapp/database/push_notification.dart';
import 'package:distanciapp/models/Client.dart';
import 'package:distanciapp/ui/MyApp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:distanciapp/signup/signup.dart';
//import 'package:distanciapp/signin/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService.initializeApp();

  runApp(const MyApp());
}


