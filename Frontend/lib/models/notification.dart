import 'package:flutter/material.dart';

class Notification{
  //final Notification notification;
   String fecha;
   String hora;
   String userd;
   String location;

  Notification({required this.fecha, required this.hora, required this.userd, required this.location});

   String getFecha(){
    return fecha;
   }
   String getHora(){
     return hora;
   }
   String getUserd(){
     return userd;
   }
   String getLocation(){
     return location;
   }


}
class Lista{
  List <Notification> notificaciones;
  Lista(this.notificaciones);

  int getTotal(){ // Devuelve total de notificaciones en el historial
    int total= notificaciones.length;
    return total;
  }
  List getLista(){
    return notificaciones;
  }

  String getItemf(index){ // obtiene una notificacion en especifico
    Notification notifi= notificaciones[index];
    String f=notifi.fecha;
    return f;
  }
  String getItemh(index){ // obtiene una notificacion en especifico
    Notification notifi= notificaciones[index];
    String h=notifi.hora;
    return h;
  }
  String getItemu(index){ // obtiene una notificacion en especifico
    Notification notifi= notificaciones[index];
    String u=notifi.userd;
    return u;
  }
  String getIteml(index){ // obtiene una notificacion en especifico
    Notification notifi= notificaciones[index];
    String l=notifi.location;
    return l;
  }

  void addItem(Notification notificacion){ //agrega notificacion a la lista
    notificaciones.add(notificacion);
  }

}

Lista notificaciones = new Lista(
    [Notification(fecha: "18/10/2021", hora: "13:05 p.m.", userd: "User1", location: "Domo CTI"),
  Notification(fecha: "16/10/2021", hora: "10:14 a.m.", userd: "User3", location: "Hallway 1 CTI")]);



//List <Notification> notificacioness =
//[Notification("18/10/2021","13:05 p.m."),
  //Notification("16/10/2021","10:14 a.m.")];

/*
class Notification {

  String fecha;
  String hora;

  Notification({ required this.fecha, required this.hora });
}
List notificaciones = [
  Notification(fecha:"18/10/2021",hora:"13:05 p.m."),
  Notification(fecha:"18/10/2021",hora:"13:05 p.m.")];

class Lista{
  List <Notification> notificaciones;
  Lista(this.notificaciones);

  int getTotal(){ // Devuelve total de notificaciones en el historial
    int total= notificaciones.length;
    return total;
  }
  List getLista(){
    return notificaciones;
  }

  Notification getItem(index){ // obtiene una notificacion en especifico
    Notification notifi= notificaciones[index];
    return notifi;
  }
  void addItem(Notification notificacion){ //agrega notificacion a la lista
    notificaciones.add(notificacion);
  }

}

 */