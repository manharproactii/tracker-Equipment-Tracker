import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navkar_tracker/pages/phase2/location_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/login/intro_page.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {

  HttpOverrides.global =  MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("remember value is${prefs.getBool('remember')}");
  bool remember = prefs.getBool('remember');
  String role = prefs.getString('Role');

  print("object role $role");

  if (remember != null) {
    // runApp(MaterialApp( debugShowCheckedModeBanner: false,home:  LocationPage()));
    // if(role == "Admin"){
      runApp(MaterialApp( debugShowCheckedModeBanner: false,home: remember!=null ?  LocationPage() :  IntroPage()));
    // } else if(role == "Operations"){
    //   runApp(MaterialApp( debugShowCheckedModeBanner: false,home: remember!=null ? DashboardOperation() :  IntroPage()));
    // } else if(role == "Accounts"){
    //   runApp(MaterialApp( debugShowCheckedModeBanner: false,home: remember!=null ? DashboardAccount() :  IntroPage()));
    // }
  } else {
    runApp(MaterialApp(

      debugShowCheckedModeBanner: false,
        home: IntroPage()));
  }
  //runApp(MaterialApp(home: DashboardManagement()));
}
