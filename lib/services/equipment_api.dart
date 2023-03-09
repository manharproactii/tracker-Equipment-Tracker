import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/equipment_model.dart';



class EquipmentApi {
  static Future<List<Equipment>> getEquipmentSuggestions(String query,String locationId)  async {

    print("query ${query} == Location ID ${locationId}");
    Uri url = Uri.parse('https://103.236.154.131/EQPTrackingAPI/api/Navkar/GetAllEquipmentList?SearchText=$query&LocationID=$locationId');


    try{
      print("url  =======> ${url.toString()}");
      // final
      final response = await http.get(url);
      print("response.body  =======> ${response.body.toString()}");
      print("response.statusCode  =======> ${response.statusCode.toString()}");
      if (response.statusCode.toString() == "200") {
        var  result = json.decode(response.body);

        EquipmentModel equipmentModel;
        equipmentModel = (EquipmentModel.fromJson(result));

        print("equipmentModel.equipmentList ${equipmentModel.equipmentList.length}");


        return equipmentModel.equipmentList;

      } else {
        throw Exception();
      }
    }

    catch(e){
      print("error ============> ${e}");
    }

    // if (response.statusCode.toString() == "200") {
    //   var  result = json.decode(response.body);
    //
    //   EquipmentModel equipmentModel;
    //   equipmentModel = (EquipmentModel.fromJson(result));
    //
    //   print("equipmentModel.equipmentList ${equipmentModel.equipmentList.length}");
    // // return  markLocationModel.markLocation.where((markLocation) {
    // //     final nameLower = markLocation.containerNo.toLowerCase();
    // //     final queryLower = query.toLowerCase();
    // //     return nameLower.contains(queryLower);
    // //   });
    //
    //   return equipmentModel.equipmentList;
    //
    //   return result.map((json) => MarkLocation.fromJson(json)).where((user) {
    //     final nameLower = user.containerNo.toLowerCase();
    //     final queryLower = query.toLowerCase();
    //
    //     return nameLower.contains(queryLower);
    //   }).toList();
    // } else {
    //   throw Exception();
    // }
  }
}