import 'package:flutter/material.dart';
import 'package:distanciapp/models/notification.dart';

class Notification{
  //final Notification notification;
  final String fecha;
  final String hora;

  Notification(this.fecha, this.hora);

  String getFecha(){
    return fecha;
  }
  String getHora(){
    return hora;
  }

}

List <Notification> notificacioness =
[Notification("18/10/2021","13:05 p.m."),
 Notification("16/10/2021","10:14 a.m.")];