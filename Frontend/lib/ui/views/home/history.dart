import 'package:distanciapp/constants/colors.dart';
import 'package:distanciapp/models/notification.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _History();
}
class _History extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body:Center( child: _body()),
     // bottomNavigationBar: _bottomNavBar(context),
    );
  }
  AppBar _buildAppBar(context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          const Text(
            "Alerts History",
            style: TextStyle(color: Colors.black),
          ),
          Text("${notificaciones.getTotal()} notifications",
             style: Theme.of(context).textTheme.caption)
        ],
      ),
      elevation: 0,
    );
  }
  Widget _body() {
   // int i=notificaciones.getTotal();
    List <int> numero=[];
    for (int n=0; n<notificaciones.getTotal(); n++){
      numero.add(n);};
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
          for ( var i in numero )
            _noti("${notificaciones.getItemf(i)}",
                "${notificaciones.getItemh(i)}",
                "${notificaciones.getItemu(i)}",
                "${notificaciones.getIteml(i)}"),
            Container(height: 20),

  ],),);
  }

  Widget _noti(String fecha, String hora, String userd, String location) {
    return Container(
      width: 400,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Text("\n"),
            Text("Distance is not complied with " + userd
            ,style: TextStyle( color: AppColors.text_light,
            fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Date: "+fecha + "\n"
                +"Time: "+hora + "\n"
                +"Location: "+location
              ,style: TextStyle( color: AppColors.text_light,
                fontSize: 16)),
            Text("Please take distance!",
                style: TextStyle( color: AppColors.text_light,
                fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      );


}}


