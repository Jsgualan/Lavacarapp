import 'dart:convert';

class Response {
  int? en;
  String? m;

  Response({
    this.en,
    this.m,
  });

  String toJson() => json.encode(toMap());

  Response.fromMap(Map<String, dynamic> json) {
    en = json["en"];
    m = json["m"];
  }

  Map<String, dynamic> toMap() => {
    "en": en,
    "m": m,
  };

  @override
  String toString() {
    return 'Response{en: $en, m: $m}';
  }
}