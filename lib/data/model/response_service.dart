import 'dart:convert';

import '../../domain/entities/service.dart';
import 'response.dart';

class ResponseService extends Response {
  List<Service>? lS = [];

  ResponseService({this.lS});

  factory ResponseService.fromJson(String str) =>
      ResponseService.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  ResponseService.fromMap(Map<String, dynamic> json)
      : lS = (json["lS"] == null
            ? []
            : List<Service>.from(json["lS"].map((x) => Service.fromMap(x)))),
        super.fromMap(json);

  @override
  Map<String, dynamic> toMap() => {
        "lS": lS == null ? [] : List<dynamic>.from(lS!.map((x) => x.toMap())),
      };
}
