import 'dart:async';

import '../models/equipment_summary_model.dart';
import '../models/locations.dart';
import '../services/api_clients.dart';

class EquipmentSummaryBloc{
  final _apiclient = ApiClient();

  final _equipmentController = StreamController<EquipmentSummaryModel>.broadcast();

  Stream<EquipmentSummaryModel> get equipmentSummaryStream => _equipmentController.stream;

  getEquipmentSummaryData(Locations locationsObj) async{

    try{
      final results = await _apiclient.getEquipmentSummary(locationsObj);
      _equipmentController.sink.add(results);
      print("_equipmentController $results");
    } on Exception catch(e){
      print(e.toString());
      _equipmentController.sink.addError("something went wrong ${e.toString()}");
    }

  }



  dispose(){
    _equipmentController.close();
  }

}