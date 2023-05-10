class Service {
  String? id;
  String? name;
  bool? check = false;

  Service({this.id, this.name, this.check});


  @override
  String toString() {
    return 'Service{id: $id, name: $name, check: $check}';
  }

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        check: false,
        id: json['id'],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
