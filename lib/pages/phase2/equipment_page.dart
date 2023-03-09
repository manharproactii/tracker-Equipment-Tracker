import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:navkar_tracker/models/equipment_model.dart';
import 'package:navkar_tracker/pages/phase2/equipment_summary_page.dart';
import 'package:navkar_tracker/utils/alerts.dart';
import 'package:navkar_tracker/utils/app_properties.dart';
import 'package:navkar_tracker/globalVariables.dart'as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/locations.dart';
import '../../services/connection.dart';
import '../../services/equipment_api.dart';
import '../../utils/progress_dialog.dart';

class EquipmentPage extends StatefulWidget {
  final Locations locationsObj;

  const EquipmentPage({Key key, this.locationsObj}) : super(key: key);
  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {




  final format = DateFormat("yyyy-MM-dd");
  SharedPreferences prefs;
  String role;
  bool isShow=false;
  // TextEditingController controllerContainerNo = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController controllerEquipmentName = TextEditingController();


  var focusNode = FocusNode();
  Equipment equipmentObj;

  DateTime selectedDate = DateTime.now();
  String date = "";
  String dateSendAPI = "";
  @override
  initState(){
    super.initState();
    print("widget.markLocationObj ==> ${widget.locationsObj.locationName}");
    final DateFormat formatter = DateFormat('dd-MM-yyyy hh:mm:ss');
    final DateFormat formatterSendAPI = DateFormat('yyyy-MM-dd hh:mm');
    date = formatter.format(selectedDate);
    dateSendAPI = formatterSendAPI.format(selectedDate);
    dateController.text = date;
    initRole();



    // icdBloc.fetchICDCollection();
    // cfsBloc.fetchCFSCollection();


  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        FocusManager.instance.primaryFocus?.unfocus();
        return true;
      },
      child: Scaffold(
        // backgroundColor: background,
        appBar:_appBar(),
        body:

        _body()
        // getMarkLocationList.isEmpty? SizedBox(
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   child:  Center(child: CircularProgressIndicator(color: bg,)),
        // ):
        // _body(),
      ),
    );
  }

  Widget _appBar(){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
          FocusManager.instance.primaryFocus?.unfocus();
          // if(globals.Role == "Admin"){
          //   Navigator.push(context, MaterialPageRoute(builder: (c) => DashboardAdmin()));
          // }
          // if(globals.Role == "Accounts"){
          //   Navigator.push(context, MaterialPageRoute(builder: (c) => DashboardAccount()));
          // }
          // if(globals.Role == "Operations"){
          //   Navigator.push(context, MaterialPageRoute(builder: (c) => DashboardOperation()));
          // }

          // if(role == "Admin"){
          //   Navigator.push(context, MaterialPageRoute(builder: (c) => DashboardAdmin()));
          // }
          // if(role == "Accounts"){
          //   Navigator.push(context, MaterialPageRoute(builder: (c) => DashboardAccount()));
          // }
          // if(role == "Operations"){
          //   Navigator.push(context, MaterialPageRoute(builder: (c) => DashboardOperation()));
          // }
        }
        ,),
      backgroundColor: bg,
      centerTitle: true,
      elevation: 0,
      title: Text("Equipment Tracking",
        style: headingBar,),
      actions: [
        IconButton(
            icon: Icon(Icons.summarize_outlined),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => EquipmentSummaryPage(locationsObj: widget.locationsObj,)));
            }),
      ],
    );
  }

  String selectedValue = "USA";


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2099, 8),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yyyy hh:mm:ss');
        date = formatter.format(picked);
        dateController.text = date;
        // }
        selectedDate = picked;
        print("selectedDate $date");
      });
    }
  }

  Widget _body(){

    // if(getMarkLocationList.isEmpty){
    //   return Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     child: Center(child: CircularProgressIndicator()),
    //   );
    // }else{
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              // Text("Equipment Name : ${widget.equipmentObj.equipmentName}",style: TextStyle(fontSize: 16)),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                // margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 22, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.yellow,
                ),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.access_time,size: 25,),
                    Text(date,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                  ],
                )),
              ),
              // TextFormField(
              //   readOnly: true,
              //   onTap: () {
              //     // _selectDate(context);
              //   },
              //   textInputAction: TextInputAction.next,
              //   controller: dateController,
              //
              //   decoration: InputDecoration(
              //       labelStyle: TextStyle(
              //           color: bg,fontSize: 16
              //       ),
              //       // contentPadding: EdgeInsets.only(top:25,left: 15),
              //       hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),
              //       hintText: 'Date',
              //       labelText: 'Date',
              //       enabledBorder:OutlineInputBorder(
              //         //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       focusedBorder:OutlineInputBorder(
              //         // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(8.0),
              //         // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
              //       ),
              //       focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(8.0),
              //         //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
              //       )
              //   ),
              // ),

              SizedBox(height: 20,),

              Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                // margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 20, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.yellow,
                ),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Icon(Icons.location_on_outlined,size: 30,),
                    Text(widget.locationsObj.locationName,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),),
                  ],
                )),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15),
                child: Container(
                  // padding: EdgeInsets.all(16),
                  child: TypeAheadField<Equipment>(


                    errorBuilder: (BuildContext context, Object error) {
                      // print("focusNode.hasFocus ==================> ${focusNode.hasFocus}");
                      if(controllerEquipmentName.text.isEmpty && focusNode.hasFocus){
                        // return const Padding(
                        //   padding:  EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
                        //   child: Text(
                        //       'Please enter 1 or more characters',
                        //
                        //   ),
                        // );
                      }else{
                        // return Padding(
                        //   padding: EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
                        //   child: Text(
                        //       '$error',
                        //       style: TextStyle(
                        //           color: Theme.of(context).errorColor
                        //       )
                        //   ),
                        // );
                      }

                    }
                    ,

                    noItemsFoundBuilder: (BuildContext context) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20.0,bottom: 20,left: 15),
                        child: Text(
                          'No data found!',

                        ),
                      );
                    }
                    ,
                    hideSuggestionsOnKeyboardHide: false,
                    textFieldConfiguration: TextFieldConfiguration(
                      focusNode: focusNode,
                      controller: controllerEquipmentName,
                      onChanged: (value){
                        if(value.isEmpty){
                          setState(() {
                            equipmentObj = null;
                          });

                        }
                      },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: bg,fontSize: 16
                          ),
                          // contentPadding: EdgeInsets.only(top:25,left: 15),
                          hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),
                          hintText: 'Equipment No',
                          labelText: 'Equipment No',
                          enabledBorder:OutlineInputBorder(
                            //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedBorder:OutlineInputBorder(
                            // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(0.0),
                            // borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
                          ),
                          focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(0.0),
                            //borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
                          )
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      print("controllerEquipmentName.text ==========> ${controllerEquipmentName.text}");
                      print("widget.locationsObj.locationID ==========> ${widget.locationsObj.locationID}");
                      return EquipmentApi.getEquipmentSuggestions(controllerEquipmentName.text,widget.locationsObj.locationID.toString());
                    },
                    // suggestionsCallback: UserApi.getUserSuggestions(),
                    itemBuilder: (context, Equipment suggestion) {
                      final user = suggestion;

                      return ListTile(
                        title: Text(user.equipmentNo),
                      );
                    },

                    onSuggestionSelected: (Equipment suggestion) {
                      // final equipmentObj = suggestion;
                      setState(() {
                        controllerEquipmentName.text = suggestion.equipmentNo;
                        equipmentObj = suggestion;
                      });

                    //  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MarkLocationPage(equipmentObj: equipmentObj,)));
                      // ScaffoldMessenger.of(context)
                      //   ..removeCurrentSnackBar()
                      //   ..showSnackBar(SnackBar(
                      //     content: Text('Selected user: ${user.name}'),
                      //   ));
                    },
                  ),
                ),
              ),

              // SizedBox(height: 5,),
              SizedBox(height: 20,),
              // IgnorePointer(
              //   // ignoring:  false,
              //   child: DropdownButtonFormField<MarkLocation>(
              //       decoration: InputDecoration(
              //           labelStyle: TextStyle(
              //               color: bg,fontSize: 16
              //           ),
              //           hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),
              //           hintText: 'Location',
              //           labelText: 'Location',
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
              //       // dropdownColor: Colors.blueAccent,
              //       value: markLocationValue == null ? markLocationValue : getMarkLocationList.where( (i) => i.locationName == widget.markLocationObj.locationName).first,
              //       onChanged: (MarkLocation newValue) {
              //         setState(() {
              //           markLocationValue = newValue;
              //         });
              //       },
              //       items: dropdownItems),
              // ),
              // SizedBox(height: 20,),

              equipmentObj != null?
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15),
                child: InkWell(
                  onTap: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    inOutAPI();

                  },
                  child:
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.all(20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.green,
                    ),
                    child: Center(child: Text(equipmentObj.availableFor,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ):Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15),
                child: InkWell(
                  onTap: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    inOutAPI();

                  },
                  child:
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.all(20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.green,
                    ),
                    child: Center(child: Text("IN / OUT",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ),
              // SizedBox(height: 20,),
              // InkWell(
              //   onTap: (){
              //     // FocusManager.instance.primaryFocus?.unfocus();
              //     // _saveLocation();
              //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewSummaryPage()));
              //
              //   },
              //   child: Container(
              //     height: 50,
              //     width: MediaQuery.of(context).size.width,
              //     // margin: EdgeInsets.all(20),
              //     padding: EdgeInsets.only(left: 10, right: 10),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       color: Colors.green,
              //     ),
              //     child: Center(child: Text("View Summary",style: headingBar,)),
              //   ),
              // ),


            ],
          ),
        ),
      );
    // }

  }


  inOutAPI() async {
    if(controllerEquipmentName.text.isEmpty){
      Fluttertoast.showToast(
          msg: "Please Enter Equipment No",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      SharedPreferences prefs =
      await SharedPreferences.getInstance();
      final userId = prefs.getInt('UserID') ?? '';

      print("userId  ====================> ${userId.toString()}");
      print("URL  ====================> ${Connection.insertEquipmentTrackData}");
      print("widget.locationsObj.locationID ============> ${widget.locationsObj.locationID}");
      print("equipmentObj.equipmentID ====================> ${equipmentObj.equipmentID}");
      print("dateSendAPI ====================> ${dateSendAPI}");
      print("equipmentObj.availableFor ====================> ${equipmentObj.availableFor}");

      ProgressDialog pr = ProgressDialog(context,
        isDismissible: true,);
      pr.style(message: 'Please wait...',
        progressWidget: Center(child: CircularProgressIndicator()),);
      await pr.show();

      try {
        // var response = await http.post(Uri.parse("${Connection.saveLocation}?LocationID=${markLocationValue.locationID}&AddedBy=1&ContainerNo=${controllerContainerNo.text}&EquipmentID=${widget.equipmentObj.equipmentID}"));
        var response = await http.post(
            Uri.parse(Connection.insertEquipmentTrackData), body: {
          'LocationID': widget.locationsObj.locationID.toString(),
          'EquipmentID': equipmentObj.equipmentID.toString(),
          'EquipmentDate': dateSendAPI,
          'EntryType': equipmentObj.availableFor,
          'AddedBy': userId.toString()
        });
        var results = json.decode(response.body);
        print('response == $results ');
        pr.hide();
        if (response.statusCode == 200) {
          setState(() {
            controllerEquipmentName.clear();
            focusNode.requestFocus();
            equipmentObj = null;
          });

          Fluttertoast.showToast(
              msg: results["Messege"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              // backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          pr.hide();
        } else {
          Fluttertoast.showToast(
              msg: results["Messege"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              // backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          pr.hide();
        }
      }catch(error){
        print('error ===================>  $error ');
      }



    }



  }


  Future<void> initRole() async {
    prefs = await SharedPreferences.getInstance();
    role = prefs.getString('Role');
    print("object role $role");
    // _getLocation();

    // _getContainerNo();
    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });
  }


}

class DescriptionView extends StatefulWidget {
  final List<Widget> children;
  DescriptionView({this.children});
  @override
  _DescriptionViewState createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  // List<String> _detailTypes = ['ICD', 'CFS'];
  List<String> _detailTypes = ['ICD'];
  PageController _pageController;
  List<double> _heights;
  int _currentPage = 0;
  double get _currentHeight  => _heights[_currentPage];

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    _pageController = PageController()..addListener(() {
      final _newPage = _pageController.page.round();
      if (_currentPage != _newPage) {
        setState(() => _currentPage = _newPage);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 60,
              color: footer1,
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _detailTypes.length,
                  itemBuilder: (c, i) {
                    return GestureDetector(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: _currentPage == i ?
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width ,
                            height: 30,
                            child: Center(
                              child: Text('${_detailTypes[i]}', style: optionStyle, textAlign: TextAlign.center,),
                            ),
                          ) :
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width ,
                            height: 30,
                            margin: EdgeInsets.only(left: 8),
                            //color: footer1,
                            child: Center(
                              child: Text('${_detailTypes[i]}', style: optionStyle1,  textAlign: TextAlign.center,),
                            ),
                          )
                      ),
                      onTap: () {
                        setState(() {
                          _currentPage = i;
                          _pageController.animateToPage(i, curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 400));
                        });
                      },
                    );
                  }),
            ),
            TweenAnimationBuilder<double>(
              curve: Curves.easeInOutCubic,
              tween: Tween<double>(begin: _heights[0], end: _currentHeight),
              duration: const Duration(milliseconds: 100),
              builder: (c, v, child) {
                return SizedBox(height: v, child: child);
              },
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                children: _sizeReportingChildren.asMap().map((index, child) =>
                    MapEntry(index, child)).values.toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children.asMap().map((index, child) =>
      MapEntry(index, OverflowBox(
        minHeight: 0, maxHeight: double.infinity,
        alignment: Alignment.topCenter,
        child: SizeReportingWidget(
          onSizeChanged: (size) => setState(() => _heights[index] = size?.height ?? 0),
          child: Align(child: child,),
        ),
      ))).values.toList();

}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChanged;
  SizeReportingWidget({this.child, this.onSizeChanged});
  @override
  _SizeReportingWidgetState createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (this.mounted) {
        _notifySize();
      }
    });
    return widget.child;
  }

  _notifySize() {
    final size = context?.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChanged(size);
    }
  }

}
