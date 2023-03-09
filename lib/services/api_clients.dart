

import 'package:http/http.dart'as http;
import 'dart:convert';
import '../models/equipment_summary_model.dart';
import '../models/locations.dart';
import 'connection.dart';

class ApiClient {


  Future<EquipmentSummaryModel> getEquipmentSummary(Locations locationsObj) async {
    print("getEquipmentSummary URL ========> ${Connection.getEquipmentTrackingSummary}?LocationID=${locationsObj.locationID.toString()}");
    var response = await http.get(Uri.parse("${Connection.getEquipmentTrackingSummary}?LocationID=${locationsObj.locationID.toString()}"));
    var result = json.decode(response.body);

    EquipmentSummaryModel equipmentSummaryModel;

    print("equipmentSummaryModel result $result");
    equipmentSummaryModel = (EquipmentSummaryModel.fromJson(result));
    print('_markLocation details ${equipmentSummaryModel}');
    return equipmentSummaryModel;
  }


}