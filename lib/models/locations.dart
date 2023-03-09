class LocationsModel {
  List<Locations> locationsList;

  LocationsModel({this.locationsList});

  factory LocationsModel.fromJson(Map<String, dynamic> json) => LocationsModel(
        locationsList: List<Locations>.from(
            json["Location"].map((x) => Locations.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Location": List<dynamic>.from(locationsList.map((x) => x)),
      };
}

class Locations {
  int locationID;
  String locationName;
  bool isActive;

  Locations(
      {this.locationID,
      this.locationName,
      this.isActive});



  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    locationID: json["LocationID"],
    locationName: json["LocationName"],
    isActive: json["IsActive"],
      );

}
