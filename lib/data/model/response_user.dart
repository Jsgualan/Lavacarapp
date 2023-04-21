import 'dart:convert';

import '../../domain/entities/user.dart';
import 'response.dart';

class ResponseUser extends Response {
  User? u = User();

  ResponseUser({this.u});

  factory ResponseUser.fromJson(String str) =>
      ResponseUser.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  ResponseUser.fromMap(Map<String, dynamic> json)
      : u = json["u"] == null ? null : User.fromMap(json["u"]),
        super.fromMap(json);

  @override
  Map<String, dynamic> toMap() => {
        "u": u == null ? null : u!.toMap(),
      };
}
