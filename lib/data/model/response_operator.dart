import 'dart:convert';

import '../../domain/entities/user.dart';
import 'response.dart';

class ResponseOperator extends Response {
  List<User>? lP = [];

  ResponseOperator({this.lP});

  factory ResponseOperator.fromJson(String str) =>
      ResponseOperator.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  ResponseOperator.fromMap(Map<String, dynamic> json)
      : lP = (json["lP"] == null
            ? []
            : List<User>.from(json["lP"].map((x) => User.fromMap(x)))),
        super.fromMap(json);

  @override
  Map<String, dynamic> toMap() => {
        "lP": lP == null ? [] : List<dynamic>.from(lP!.map((x) => x.toMap())),
      };
}
