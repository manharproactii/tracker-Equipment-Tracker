
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AlertDialogs{
  static showAlertAndBack(BuildContext context, String title, String message,VoidCallback onTap) {
    showDialog(context: context,
      builder: (BuildContext c) {
     return   AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Okay", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
                onTap();
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
        // return CupertinoAlertDialog(
        //   content: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Text(title,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        //       SizedBox(height: 10,),
        //       Text(message,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
        //       SizedBox(height: 10,),
        //       Divider(thickness: 1, color: Colors.grey,),
        //       SizedBox(height: 10,),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //         TextButton(
        //             onPressed: ()async{
        //               Navigator.pop(context);
        //             },
        //             child: Text("No", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,)),
        //         TextButton(
        //             onPressed: ()async{
        //               onTap();
        //             },
        //             child: Text("Yes", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,))
        //       ],)
        //
        //
        //     ],
        //   ),
        // );
      },
    );

  }

}