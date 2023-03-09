class EquipmentModel {
  List<Equipment> equipmentList;

  EquipmentModel({this.equipmentList});

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => EquipmentModel(
    equipmentList: List<Equipment>.from(
            json["Equipment"].map((x) => Equipment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Equipment": List<dynamic>.from(equipmentList.map((x) => x)),
      };
}

class Equipment {
  int locationID;
  int equipmentID;
  String equipmentNo;
  String availableFor;
  int equipmentTypeID;
  String equipmentType;
  bool isActive;

  Equipment(
      {this.locationID,
      this.equipmentID,
        this.equipmentNo,
        this.availableFor,
        this.equipmentTypeID,
        this.equipmentType,
      this.isActive});



  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
    locationID: json["LocationID"],
    equipmentID: json["EquipmentID"],
    equipmentNo: json["EquipmentNo"],
    availableFor: json["AvailableFor"],
    equipmentTypeID: json["EquipmentTypeID"],
    equipmentType: json["EquipmentType"],
    isActive: json["IsActive"],
      );

}
