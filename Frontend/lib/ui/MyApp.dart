import 'package:distanciapp/constants/colors.dart';
import 'package:distanciapp/ui/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyApp();
}
class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light),
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}