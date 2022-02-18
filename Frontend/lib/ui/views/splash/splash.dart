import 'package:distanciapp/constants/colors.dart';
import 'package:distanciapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashView extends StatefulWidget {
  @override
  _SplashView createState() => _SplashView();
}
class _SplashView extends State<SplashView> {
  String _imageBackground = "bg.jpg";
  Timer? _delaySplash;
  @override
  void initState() {
    super.initState();
    _delaySplash = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }
  @override
  void dispose() {
    super.dispose();
    _delaySplash!.cancel();
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
            child: _bodySplash()));
  }
  Widget _bodySplash() {
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
                Container(height: 250),
                const Image(
                  image: AssetImage('assets/images/logoCr.png'),
                  height: 225,
                  alignment: Alignment.center,
                ),
                Container(height: 24),
                const Text(
                  "Social Distancing Control System",
                  style: TextStyle(fontSize: 16, color:
                  Colors.white60, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 1),
              ],
            ),
          )),
    );
  }
  /**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Util.sizeScreen(context: context).width *
                  0.40,
              height: Util.sizeScreen(context: context).width *
                  0.40,

                //child: Image(
                  //  image: AssetImage('assets/images/logocrowd.png')

                //)
              child: Icon(Icons.social_distance_rounded, color:
              AppColors.text_light,size: 150,),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "WifiCrowd Distance",
              style: TextStyle(
                  fontSize: 32,
                  color: AppColors.text_light,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }*/
}