import 'package:distanciapp/ui/views/home/history.dart';
import 'package:distanciapp/ui/views/home/home_view.dart';
import 'package:distanciapp/ui/views/login/login_view.dart';
import 'package:distanciapp/ui/views/register/register_view.dart';
import 'package:distanciapp/ui/views/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/register':
        return MaterialPageRoute(builder: (_) => Registerview());
      //case '/home':
       // return MaterialPageRoute(builder: (_) => HomeView());
      case '/history-view':
        return MaterialPageRoute(builder: (_) => History());
      default:
        return _errorRoute();
  }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("ERROR"),
        ),
      );
    });
  }
}