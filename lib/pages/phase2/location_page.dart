import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:navkar_tracker/utils/alerts.dart';
import 'package:navkar_tracker/utils/app_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/locations.dart';
import '../../services/connection.dart';
import 'equipment_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  SharedPreferences prefs;
  String role;
  TextEditingController controllerEquipmentName = TextEditingController();
  var focusNode = FocusNode();
  List<Locations> getLocationsList = [];
  Locations locationsValue;



  @override
  initState() {
    super.initState();
    initRole();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: background,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.arrow_back,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     FocusManager.instance.primaryFocus?.unfocus();
      //
      //     if (role == "Admin") {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (c) => DashboardAdmin()));
      //     }
      //     if (role == "Accounts") {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (c) => DashboardAccount()));
      //     }
      //     if (role == "Operations") {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (c) => DashboardOperation()));
      //     }
      //   },
      // ),
      backgroundColor: bg,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Location",
        style: headingBar,
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              Alerts.showLogOut(context, "LogOut", "Are you sure?");
            }),
      ],
    );
  }

  String selectedValue = "USA";


  Widget _body() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              DropdownButtonFormField<Locations>(
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                // decoration: InputDecoration(
                //   enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blue, width: 2),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.blue, width: 2),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   filled: true,
                //   // fillColor: Colors.blueAccent,
                // ),


                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: bg,fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      // contentPadding: EdgeInsets.only(top:25,left: 15),
                      hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14),fontWeight: FontWeight.bold),
                      // lab: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14),fontWeight: FontWeight.bold),
                      hintText: 'Location',
                      labelText: 'Location',

                      enabledBorder:OutlineInputBorder(
                        //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder:OutlineInputBorder(
                        // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(8.0),
                        // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
                      ),
                      focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(8.0),
                        //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
                      )
                  ),
                  // dropdownColor: Colors.blueAccent,

                  value: locationsValue,
                  onChanged: (Locations newValue) {
                    setState(() {
                      locationsValue = newValue;
                      print("onChanged =========> ${locationsValue.locationName}");
                    });
                  },
                  items: dropdownItems),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   // padding: EdgeInsets.all(16),
              //   child: TypeAheadField<MarkLocation>(
              //
              //     errorBuilder: (BuildContext context, Object error) {
              //       // print("focusNode.hasFocus ==================> ${focusNode.hasFocus}");
              //       if(controllerEquipmentName.text.isEmpty && focusNode.hasFocus){
              //         // return const Padding(
              //         //   padding:  EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
              //         //   child: Text(
              //         //       'Please enter 1 or more characters',
              //         //
              //         //   ),
              //         // );
              //       }else{
              //         // return Padding(
              //         //   padding: EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
              //         //   child: Text(
              //         //       '$error',
              //         //       style: TextStyle(
              //         //           color: Theme.of(context).errorColor
              //         //       )
              //         //   ),
              //         // );
              //       }
              //
              //     }
              //     ,
              //
              //     noItemsFoundBuilder: (BuildContext context) {
              //       return const Padding(
              //         padding: EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
              //         child: Text(
              //           'No data found!',
              //
              //         ),
              //       );
              //     }
              //     ,
              //     hideSuggestionsOnKeyboardHide: false,
              //     textFieldConfiguration: TextFieldConfiguration(
              //       focusNode: focusNode,
              //       controller: controllerEquipmentName,
              //       decoration: InputDecoration(
              //           labelStyle: TextStyle(
              //               color: bg,fontSize: 16
              //           ),
              //           // contentPadding: EdgeInsets.only(top:25,left: 15),
              //           hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),
              //           hintText: 'Equipment Name',
              //           labelText: 'Equipment Name',
              //           enabledBorder:OutlineInputBorder(
              //             //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
              //             borderRadius: BorderRadius.circular(8.0),
              //           ),
              //           focusedBorder:OutlineInputBorder(
              //             // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
              //             borderRadius: BorderRadius.circular(8.0),
              //           ),
              //           errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(8.0),
              //             // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
              //           ),
              //           focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(8.0),
              //             //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
              //           )
              //       ),
              //     ),
              //     suggestionsCallback: (pattern) {
              //       print("controllerEquipmentName.text ==========> ${controllerEquipmentName.text}");
              //       return MarkLocationApi.getMarkLocationSuggestions(controllerEquipmentName.text,true);
              //     },
              //     // suggestionsCallback: UserApi.getUserSuggestions(),
              //     itemBuilder: (context, MarkLocation suggestion) {
              //       final user = suggestion;
              //
              //       return ListTile(
              //         title: Text(user.equipmentName),
              //       );
              //     },
              //
              //     onSuggestionSelected: (MarkLocation suggestion) {
              //       final equipmentObj = suggestion;
              //       controllerEquipmentName.text = equipmentObj.equipmentName;
              //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => MarkLocationPage(equipmentObj: equipmentObj,)));
              //       // ScaffoldMessenger.of(context)
              //       //   ..removeCurrentSnackBar()
              //       //   ..showSnackBar(SnackBar(
              //       //     content: Text('Selected user: ${user.name}'),
              //       //   ));
              //     },
              //   ),
              // ),

              // SizedBox(height: 5,),

              InkWell(
                onTap: (){
                  // FocusManager.instance.primaryFocus?.unfocus();
                  // _saveLocation();
                  if(locationsValue == null){
                    Fluttertoast.showToast(
                        msg: "Please select location",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        // backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }else{
                    print("markLocationValue ==> ${locationsValue.locationName}");
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => EquipmentPage(locationsObj: locationsValue,)));
                  }



                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.all(20),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  child: Center(child: Text("SUBMIT",style: TextStyle(fontSize: 16,color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Locations>> get dropdownItems{
    List<DropdownMenuItem<Locations>> menuItems = [
      // DropdownMenuItem(child: Text("USA"),value: "USA"),
      // DropdownMenuItem(child: Text("Canada"),value: "Canada"),
      // DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
      // DropdownMenuItem(child: Text("England"),value: "England"),
    ];

    for(int i=0;i<getLocationsList.length;i++){
      menuItems.add(DropdownMenuItem(child: Text("${getLocationsList[i].locationName}"),value: getLocationsList[i]))
      ;
    }
    return menuItems;
  }



  Future<void> initRole() async {
    prefs = await SharedPreferences.getInstance();
    role = prefs.getString('Role');
    print("object role $role");
    _getLocation();
  }

  _getLocation() async {
    print("Connection.getLocation URL========== ${Connection.getLocationList}");
    var response = await http.get(Uri.parse(Connection.getLocationList));
    // var results = json.decode(response.body);
    var result = json.decode(response.body);
    print('response == $result  ${response.body}');

    LocationsModel locationsModel;
    locationsModel = (LocationsModel.fromJson(result));

    // MarkLocationModel markLocationModel = MarkLocationModel.fromJson(results);
    setState(() {
      getLocationsList = locationsModel.locationsList;
      print("getLocationsList  ===============> ${getLocationsList.length}");
    });



  }
}
