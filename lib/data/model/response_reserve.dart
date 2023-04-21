import 'dart:convert';

import '../../domain/entities/schedule.dart';
import 'response.dart';

class ResponseReserve extends Response {
  Reserve? h = Reserve();

  ResponseReserve({this.h});

  factory ResponseReserve.fromJson(String str) =>
      ResponseReserve.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  ResponseReserve.fromMap(Map<String, dynamic> json)
      : h = json["h"] == null ? null : Reserve.fromMap(json["h"]),
        super.fromMap(json);

  @override
  Map<String, dynamic> toMap() => {
        "h": h == null ? null : h!.toMap(),
      };
}
