import 'package:flutter/material.dart';
import '../login/login_page.dart';
import '../../utils/app_properties.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: bg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Image.asset("assets/logo_big.png",height: 300,width: 300,),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Welcome,",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                ),),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 40),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 70,
                  width: 70,
                  child: IconButton(
                    onPressed: (){

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => LoginPage()));
                    },
                    icon: Icon(Icons.arrow_forward_outlined,
                    color: purple,
                    size: 35,),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.shade200,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ]
                  ),
                ),

              ),
            ),
            //SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
