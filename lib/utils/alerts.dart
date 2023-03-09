import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/login/login_page.dart';

class Alerts {

  static showLogOut(BuildContext context, String title, String message) {
    showDialog(context: context,
      builder: (BuildContext context) {
        return Platform.isIOS ? CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Okay", style: TextStyle(color: Colors.red),),
              onPressed: () async{
                SharedPreferences _prefs = await SharedPreferences.getInstance();
                _prefs.clear();
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => LoginPage()), (route) => false);
              },
            ),
            CupertinoButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ) :

        AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Okay", style: TextStyle(color: Colors.red),),
              onPressed: () async{
                SharedPreferences _prefs = await SharedPreferences.getInstance();
                _prefs.clear();
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => LoginPage()), (route) => false);
              },
            ),
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showExit(BuildContext context, String title, String message) {
    showDialog(context: context,
      builder: (BuildContext context) {
        return Platform.isIOS ? CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Okay", style: TextStyle(color: Colors.red),),
              onPressed: () async{
                exit(0);
              },
            ),
            CupertinoButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ) : AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Okay", style: TextStyle(color: Colors.red),),
              onPressed: () async{
                exit(0);
              },
            ),
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showAlertAndBack(BuildContext context, String title, String message) {
    showDialog(context: context,
      builder: (BuildContext c) {
        return Platform.isIOS ? CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Okay", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(c).pop();
                //Navigator.pop(context, true);
              },
            ),
          ],
        ) : AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Okay", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(c).pop();
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showAlertLogin(BuildContext context) {
    showDialog(context: context,
      builder: (BuildContext c) {
        return Platform.isIOS ? CupertinoAlertDialog(
          title: Text('Login Required'),
          content: Text('You must login first.'),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(c).pop();
              },
            ),
            CupertinoButton(
              child: Text("Login", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(c).pop();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
              },
            ),
          ],
        ) : AlertDialog(
          title: Text('Login Required'),
          content: Text('You must login first.'),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(c).pop();
              },
            ),
            TextButton(
              child: Text("Login", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(c).pop();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

}