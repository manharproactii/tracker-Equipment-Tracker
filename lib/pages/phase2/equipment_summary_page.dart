import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/equipment_summary_bloc.dart';
import '../../models/equipment_summary_model.dart';
import '../../models/locations.dart';
import '../../services/connection.dart';
import '../../utils/alert_dialog.dart';
import '../../utils/alerts.dart';
import '../../utils/app_properties.dart';
import 'package:http/http.dart' as http;

import '../../utils/progress_dialog.dart';

class EquipmentSummaryPage extends StatefulWidget {
  final Locations locationsObj;
  const EquipmentSummaryPage({Key key, this.locationsObj}) : super(key: key);

  @override
  _EquipmentSummaryPageState createState() => _EquipmentSummaryPageState();
}

class _EquipmentSummaryPageState extends State<EquipmentSummaryPage> {
  final equipmentSummaryBloc = EquipmentSummaryBloc();

  AsyncSnapshot<EquipmentSummaryModel> as;

  @override
  initState() {
    equipmentSummaryBloc.getEquipmentSummaryData(widget.locationsObj);
    super.initState();
  }

  @override
  void dispose() {
    equipmentSummaryBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: bg,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Equipment Summary",
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

  Widget _body() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: StreamBuilder(
            stream: equipmentSummaryBloc.equipmentSummaryStream,
            builder: (c, s) {
              as = s;
              if (as.connectionState != ConnectionState.active) {
                print("CircularProgressIndicator");

                return Container(
                    height: MediaQuery.of(context).size.height-80,
                    alignment: Alignment.center,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              }
              if (s.hasError) {
                print("as3 error");

                return Container();
              }
              if (s.data.toString().isEmpty) {
                print("as3 empty");

                return Container();
              }

              if(as.data.equipmentList.isNotEmpty){
                return Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: HorizontalDataTable(
                          leftHandSideColumnWidth: 100,
                          rightHandSideColumnWidth: 540,
                          isFixedHeader: true,
                          headerWidgets: [
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Container(
                                  child: Text(
                                    'Action',
                                    style: content1,
                                    textAlign: TextAlign.center,
                                  ),
                                  alignment: Alignment.center,
                                )),
                            // Expanded(
                            //   child: Container(
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       color: Colors.green,
                            //       border: Border.all(color: Colors.white),
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('Import', style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('Export',
                            //               style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('Bond',
                            //               style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('Domestic',
                            //               style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('MNR',
                            //               style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('MISC',
                            //               style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('Credit',
                            //               style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Container(
                            //             child: Text('Total',
                            //               style: content1,
                            //               textAlign: TextAlign.center,),
                            //             alignment: Alignment.center,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )

                            Container(
                              height: 50,
                              // decoration: BoxDecoration(
                              //   color: Colors.green,
                              //   border: Border.all(color: Colors.white),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: Text(
                                      'EQP No',
                                      style: content1,
                                      textAlign: TextAlign.center,
                                    ),
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        border: Border(
                                          right: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          top: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                        )
                                      // border: Border.all(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'LOC',
                                      style: content1,
                                      textAlign: TextAlign.center,
                                    ),
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        border: Border(
                                          right: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          top: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                        )
                                      // border: Border.all(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'TYPE',
                                      style: content1,
                                      textAlign: TextAlign.center,
                                    ),
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        border: Border(
                                          right: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          top: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                        )
                                      // border: Border.all(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'DateTime',
                                      style: content1,
                                      textAlign: TextAlign.center,
                                    ),
                                    alignment: Alignment.center,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        border: Border(
                                          right: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          top: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                        )
                                      // border: Border.all(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'UserName',
                                      style: content1,
                                      textAlign: TextAlign.center,
                                    ),
                                    alignment: Alignment.center,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        border: Border(
                                          right: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          top: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                          bottom: BorderSide(
                                            //                   <--- right side
                                            color: Colors.white,
                                          ),
                                        )
                                      // border: Border.all(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          leftSideItemBuilder: _generateFirstColumnRow,
                          rightSideItemBuilder: _generateRightHandSideColumnRow,
                          itemCount: as.data.equipmentList.length,
                          rightHandSideColBackgroundColor: Colors.black,
                          leftHandSideColBackgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }else{
                return Container(
                    height: MediaQuery.of(context).size.height-80,
                    alignment: Alignment.center,
                    child: Center(
                      child: Text("No data found!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
                    ));
              }


            }));
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return InkWell(
      onTap: ()  {


        AlertDialogs.showAlertAndBack(context,"Delete?", "Are you sure you want to delete from this Equipment No?", () async {
          SharedPreferences prefs =
              await SharedPreferences.getInstance();
          final userId = prefs.getInt('UserID') ?? '';

          print("userId  ====================> ${userId.toString()}");
          print("entryID  ====================> ${as.data.equipmentList[index].entryID.toString()}");
          print("Connection.getLocation URL========== ${Connection.cancelEquipmentTrackData}?EntryID=${as.data.equipmentList[index].entryID.toString()}&CancelledBy=${userId.toString()}");

          ProgressDialog pr = ProgressDialog(context,
            isDismissible: true,);
          pr.style(message: 'Please wait...',
            progressWidget: Center(child: CircularProgressIndicator()),);
          await pr.show();

          var response = await http.post(Uri.parse("${Connection.cancelEquipmentTrackData}?EntryID=${as.data.equipmentList[index].entryID.toString()}&CancelledBy=${userId.toString()}"));
          // var results = json.decode(response.body);
          var result = json.decode(response.body);
          print('response == $result  ${response.body}');

          if (response.statusCode == 200) {

            if(result["Messege"] == "Record cancelled successfully"){
              setState(() {
                as.data.equipmentList.removeAt(index);
              });

              Fluttertoast.showToast(
                  msg: result["Messege"],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0
              );
              pr.hide();
            }else{
              Fluttertoast.showToast(
                  msg: result["Messege"],
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0
              );
              pr.hide();
            }

          } else {
            Fluttertoast.showToast(
                msg: result["Messege"],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0
            );
            pr.hide();
          }
        });



      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: bg,
          border: Border(
              left: BorderSide(color: Colors.white),
              right: BorderSide(color: Colors.white),
              bottom: BorderSide(color: Colors.white)),
        ),
        child: Image.asset(
          "assets/images/close_icon.png",
          height: 30,
          width: 30,
        )

        // Text("${as.data.markLocation[index].locationName}", style: content1,
        //   textAlign: TextAlign.center,)
        ,
        //width: 100,
        //height: 52,
        //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Container(
      color: Colors.black,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white)),
              ),
              child: Text(
                "${as.data.equipmentList[index].equipmentNo}",
                // "",
                style: content1,
                textAlign: TextAlign.center,
              ),
              //width: 100,
              //height: 52,
              //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white)),
              ),
              child: Text(
                "${as.data.equipmentList[index].locationName}",
                style: content1,
                textAlign: TextAlign.center,
              ),
              //width: 100,
              //height: 52,
              //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white)),
              ),
              child: Text(
                "${as.data.equipmentList[index].entryType}",
                style: content1,
                textAlign: TextAlign.center,
              ),
              //width: 100,
              //height: 52,
              //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.center,
            ),
          ),
          Container(
            width: 120,
            decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.white)),
            ),
            child: Text(
              "${as.data.equipmentList[index].entryDate}",
              style: content1,
              textAlign: TextAlign.center,
            ),
            //width: 100,
            //height: 52,
            //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          Container(
            width: 120,
            decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.white)),
            ),
            child: Text(
              "${as.data.equipmentList[index].username}",
              style: content1,
              textAlign: TextAlign.center,
            ),
            //width: 100,
            //height: 52,
            //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget markLocationWidget(AsyncSnapshot s) {
    //print("print arrival ${s.error}");
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20, right: 20),
          color: Colors.transparent,
          height: 30,
          // child: Text("Arrival TEUS",
          //     textAlign: TextAlign.center,
          //     style: headingBar),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          //padding: EdgeInsets.only(left: 2, right: 2),
          //margin: EdgeInsets.only(left: 2, right: 2),
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                child: Text(
                  'Container No',
                  style: content1,
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.center,
              )),
              Expanded(
                  child: Container(
                child: Text(
                  'Location',
                  style: content1,
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.center,
              )),
              // Expanded(
              //     child: Container(
              //       child: Text('ContainerNo',
              //         style: content1,
              //         textAlign: TextAlign.center,),
              //       alignment: Alignment.center,
              //     )
              // ),
            ],
          ),
        ),
        for (int i = 0; i < s.data.markLocation.length; i++)
          Container(
            height: 50,
            //padding: EdgeInsets.only(left: 2, right: 2),
            //margin: EdgeInsets.only(left: 2, right: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: bg,
                    border: Border(
                        left: BorderSide(color: Colors.white),
                        right: BorderSide(color: Colors.white),
                        bottom: BorderSide(color: Colors.white)),
                  ),
                  child: Text(
                    s.data.markLocation[i].containerNo,
                    style: content1,
                    textAlign: TextAlign.center,
                  ),
                  //width: 100,
                  //height: 52,
                  //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.center,
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.white),
                        bottom: BorderSide(color: Colors.white)),
                  ),
                  child: Text(
                    "${s.data.markLocation[i].locationName}",
                    style: content1,
                    textAlign: TextAlign.center,
                  ),
                  //width: 100,
                  //height: 52,
                  //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.center,
                )),
                // Expanded(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border(right: BorderSide(color: Colors.white),bottom: BorderSide(color: Colors.white)),
                //       ),
                //       child: Text("${s.data.markLocation[i].containerNo}", style: content1,
                //         textAlign: TextAlign.center,),
                //       //width: 150,
                //       //height: 52,
                //       //padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                //       alignment: Alignment.center,
                //     )
                // ),
              ],
            ),
          ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class DescriptionView extends StatefulWidget {
  final List<Widget> children;

  DescriptionView({this.children});

  @override
  _DescriptionViewState createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  // List<String> _detailTypes = ['ICD', 'CFS', 'NCL-1', 'NCL-2', 'NCL-3'];
  List<String> _detailTypes = ['ICD'];
  PageController _pageController;
  List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    super.initState();
    _heights = widget.children.map((e) => 0.0).toList();
    _pageController = PageController()
      ..addListener(() {
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
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            color: footer1,
            alignment: Alignment.topCenter,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _detailTypes.length,
                itemBuilder: (c, i) {
                  return GestureDetector(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _currentPage == i
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                child: Center(
                                  child: Text('${_detailTypes[i]}',
                                      style: optionStyle),
                                ),
                              )
                            : Container(
                                width: 48,
                                height: 30,
                                margin: EdgeInsets.only(left: 8),
                                //color: footer1,
                                child: Center(
                                  child: Text('${_detailTypes[i]}',
                                      style: optionStyle1),
                                ),
                              )),
                    onTap: () {
                      setState(() {
                        _currentPage = i;
                        _pageController.animateToPage(i,
                            curve: Curves.easeInOut,
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
              children: _sizeReportingChildren
                  .asMap()
                  .map((index, child) => MapEntry(index, child))
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap()
      .map((index, child) => MapEntry(
          index,
          OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChanged: (size) =>
                  setState(() => _heights[index] = size?.height ?? 0),
              child: Align(
                child: child,
              ),
            ),
          )))
      .values
      .toList();
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

  _notifySize() {
    final size = context?.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChanged(size);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (this.mounted) {
        _notifySize();
      }
    });
    return widget.child;
  }
}
