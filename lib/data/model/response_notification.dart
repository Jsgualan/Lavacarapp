import 'dart:convert';

import '../../domain/entities/booking.dart';
import 'response.dart';

class ResponseNotification extends Response {
  List<Booking>? lR = [];

  ResponseNotification({this.lR});

  factory ResponseNotification.fromJson(String str) =>
      ResponseNotification.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  ResponseNotification.fromMap(Map<String, dynamic> json)
      : lR = (json["lR"] == null
            ? []
            : List<Booking>.from(json["lR"].map((x) => Booking.fromMap(x)))),
        super.fromMap(json);

  @override
  Map<String, dynamic> toMap() => {
        "lR": lR == null ? [] : List<dynamic>.from(lR!.map((x) => x.toMap())),
      };
}
