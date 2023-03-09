class EquipmentSummaryModel {
  List<EquipmentSummary> equipmentList;

  EquipmentSummaryModel({this.equipmentList});

  factory EquipmentSummaryModel.fromJson(Map<String, dynamic> json) => EquipmentSummaryModel(
    equipmentList: List<EquipmentSummary>.from(
            json["EquipmentSummary"].map((x) => EquipmentSummary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "EquipmentSummary": List<dynamic>.from(equipmentList.map((x) => x)),
      };
}

class EquipmentSummary {
  int entryID;
  String entryDate;
  String locationName;
  int equipmentID;
  String equipmentNo;
  String equipmentType;
  String entryType;
  String username;
  bool isCancellationAllowed;

  EquipmentSummary(
      {this.entryID,
        this.entryDate,
      this.locationName,
        this.equipmentID,
        this.equipmentNo,
        this.equipmentType,
        this.entryType,
        this.username,
      this.isCancellationAllowed});

  factory EquipmentSummary.fromJson(Map<String, dynamic> json) => EquipmentSummary(
    entryID: json["EntryID"],
    entryDate: json["EntryDate"],
    locationName: json["LocationName"],
    equipmentID: json["EquipmentID"],
    equipmentNo: json["EquipmentNo"],
    equipmentType: json["EquipmentType"],
    entryType: json["EntryType"],
    username: json["Username"],
    isCancellationAllowed: json["IsActive"],
      );

}
