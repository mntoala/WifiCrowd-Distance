import 'package:distanciapp/constants/colors.dart';
import 'package:distanciapp/ui/views/login/GoogleSignInButton.dart';
import 'package:distanciapp/ui/views/login/login_bottom_sheet_view.dart';
import 'package:distanciapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:distanciapp/database/Auth_Google.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginView createState() => _LoginView();
}
class _LoginView extends State<LoginView> {
  final AuthServiceGoogle _auth = AuthServiceGoogle();
  String _imageBackground = "bg.jpg";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
            child: _bodyLogin()));
  }
  Widget _bodyLogin() {
    return SingleChildScrollView(
      child: Container(
          height: Util.sizeScreen(context: context).height,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top:
            48, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 175),
                const Image(
                    image: AssetImage('assets/images/logoCr.png'),
                    height: 225,
                    alignment: Alignment.center,
                ),
                /**const Text(
                  "Distance Alert!",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),*/
                /**Container(height: 16),
                const Text(
                  "Proyect",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                  textAlign: TextAlign.center,
                ),*/
                Container(height: 24),
                const Text(
                  "Social Distancing Control System",
                  style: TextStyle(fontSize: 16, color:
                  Colors.white60, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 1),

              Container(
                child: GoogleSignInButton(),
                ),
                /** width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onLoginTap,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(top: 16,
                            bottom: 16),
                        textStyle: TextStyle(fontSize: 16,
                            color: Colors.white),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(30))),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("assets/images/logoGoo.png"),
                            height: 35.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                  ),),*/
         /**       Container(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed("/register"),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(top: 16,
                            bottom: 16),
                        textStyle: TextStyle(fontSize: 16,
                            color: Colors.white),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(30))),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(color:
                      AppColors.text_light),
                    ),
                  ),
                ),**/
              ],
            ),
          )),
    );
  }
  Future<void> _onLoginTap() async {
    //Util.showBottomSheet(context: context, bottomSheet:
      // LoginBottomSheet());
        //GoogleSignInButton();
    //await _auth.signInGoogle();
    //setState(() {
     // _user.user(_auth.user);
    //});

}}
