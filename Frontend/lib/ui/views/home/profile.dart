import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:distanciapp/database/Auth_Google.dart';
import 'package:distanciapp/database/Database.dart';
import 'package:distanciapp/database/Item.dart';
import 'package:distanciapp/utils/Authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:distanciapp/constants/colors.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _Profile createState() => _Profile();

}
class _Profile extends State<Profile> {

  bool _isSigningOut = false;
  User? _user;
  String _imageBackground = "bg.jpg";

  @override
  void initState() {
    _user = widget._user;
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
          "User Profile",
          style: TextStyle(color: AppColors.text_light),
        ), //centerTitle: true,
      ),
      body:
      Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.55),
                  BlendMode.darken),
              image: AssetImage("assets/images/" +
                  _imageBackground),
              fit: BoxFit.fitHeight),
        ),
        //color: AppColors.blue,
        //decoration: BoxDecoration(
         // image: DecorationImage(
           //   colorFilter: ColorFilter.mode(
             //     Colors.white54.withOpacity(0.55),
               //   BlendMode.lighten),
             // image: AssetImage("assets/images/" +
               //   _imageBackground),
              //fit: BoxFit.fitHeight),
       // ),
        child:
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
            child: _profileContent(),
          ),
        ],
      ),
    );
  }
  Widget _topSection() {
    double _size = 100;
    _user!.photoURL != null;
    return ListView(
      children: [
        const SizedBox(
          height: 35,
        ),
        Container(
            width: _size,
            height: _size,
            child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: ClipRRect(
                  child: Image.network(
                    _user!.photoURL!,
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(200),
                )))
      ],
    );
  }
  Widget _profileContent() {
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
                Text("Account Information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.text_light,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Spacer(flex: 1),
              ],
            ),
          ),
         Expanded(
            child: _formItems(),
          ),
          Padding(
           padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: _isSigningOut
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppColors.primaryColor,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            onPressed: () async {
              setState(() {
                _isSigningOut = true;
              });
              await Authentication.signOut(context: context);
              setState(() {
                _isSigningOut = false;
              });
              Navigator.of(context).pushReplacementNamed("/login");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:
              20.0),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
            ),
          ),
        /**  Padding(
            padding: const EdgeInsets.symmetric(vertical:
            20.0),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed("/login"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(top: 16, bottom:
                    16),
                    textStyle: TextStyle(fontSize: 16, color:
                    Colors.white),
                    primary: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30))),
                child: Text("Log out",style:
                TextStyle(color: AppColors.text_dark),),
              ),
            ),
          ),*/
          ),]),
      ),
    );
  }
  FutureBuilder<Map<String, dynamic>> _formItems() {
    return FutureBuilder<Map<String, dynamic>>(
      future: Database().info('ac:29:3a:9e:d7:8f'),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
         print(snapshot.data);
         if (snapshot.connectionState == ConnectionState.waiting) {
           return ListView(
             children: [
               FormItem(text: "${_user!.email!}",label: "E-mail",
                 hintText: "Enter your mail",),
               FormItem(text: "${_user!.displayName!}",hintText: "Nombre",
                 label: "Username",),
               FormItem(text:"Loading" ,label: "Network", hintText:
               "Network",),
             ],
           );
         }
         return ListView(
            children: [
              FormItem(text: "${_user!.email!}",label: "E-mail",
                hintText: "Enter your mail",),
              FormItem(text: "${_user!.displayName!}",hintText: "Nombre",
                label: "Username",),
              FormItem(text:"Admin" ,label: "User", hintText:
              "User",),
              // FormItem(text:"${snapshot.data!['apName']}" ,label: "Network", hintText:
              // "Network",),
            ],
          );

      },
    );
  }
}
