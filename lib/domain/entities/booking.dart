class Booking {
  String? brand;
  String? color;
  String? date;
  String? descriptionService;
  String? hour;
  String? idOperator;
  String? idReserve;
  String? idUser;
  String? lastNameUser;
  String? numberLate;
  String? model;
  String? nameOperator;
  String? nameUser;
  int? state;
  String? typeVehicle;
  int? typeService;
  Location? location = Location();

  Booking(
      {this.brand,
      this.color,
      this.date,
      this.descriptionService,
      this.hour,
      this.idOperator,
      this.idReserve,
      this.idUser,
      this.lastNameUser,
      this.numberLate,
      this.model,
      this.nameOperator,
      this.nameUser,
      this.state,
      this.typeVehicle,
      this.typeService,
      this.location});

  @override
  String toString() {
    return 'Booking{brand: $brand, color: $color, date: $date, descriptionService: $descriptionService, hour: $hour, idOperator: $idOperator, idReserve: $idReserve, idUser: $idUser, lastNameUser: $lastNameUser, numberLate: $numberLate, model: $model, nameOperator: $nameOperator, nameUser: $nameUser, state: $state, typeVehicle: $typeVehicle, typeService: $typeService, location: $location}';
  }

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        brand: json['brand_vehicle'],
        color: json["color_vehicle"],
        date: json["date_reserve"],
        descriptionService: json["description_service"],
        hour: json["hour_reserve"],
        idOperator: json["idOperator"],
        idReserve: json["idReserve"],
        idUser: json["idUser"],
        lastNameUser: json["last_name_user"],
        model: json["model_vehicle"],
        nameOperator: json["name_operator"],
        nameUser: json["name_user"],
        state: json["state"],
        typeVehicle: json["type_vehicle"],
        typeService: json["type_service"],
        numberLate: json["late_vehicle"],
        location: json["location"] == null
            ? null
            : Location.fromMap(json["location"]),
      );

  Map<String, dynamic> toMap() => {
        "brand_vehicle": brand,
        "color_vehicle": color,
        "date_reserve": date,
        "description_service": descriptionService,
        "hour_reserve": hour,
        "idOperator": idOperator,
        "idReserve": idReserve,
        "idUser": idUser,
        "last_name_user": lastNameUser,
        "model_vehicle": model,
        "name_operator": nameOperator,
        "name_user": nameUser,
        "state": state,
        "type_vehicle": typeVehicle,
        "type_service": typeService,
        "late_vehicle": numberLate,
        "location": location == null ? null : location!.toMap(),
      };
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude}';
  }

  factory Location.fromMap(Map<String, dynamic> json) => Location(
      latitude: double.parse(json['_latitude'].toString()),
      longitude: double.parse(json["_longitude"].toString()));

  Map<String, dynamic> toMap() => {
        "_latitude": latitude ??= 0.00,
        "_longitude": longitude ??= 0.00,
      };
}
