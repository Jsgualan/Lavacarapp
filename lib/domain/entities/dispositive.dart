class Dispositive {
  String? imei;
  String? model;
  String? brand;
  String? version;
  String? versionSystem;

  Dispositive({
    this.imei,
    this.model,
    this.brand,
    this.version,
    this.versionSystem,
  });

  @override
  String toString() {
    return 'Dispositive{imei: $imei, model: $model, brand: $brand, version: $version, versionSystem: $versionSystem}';
  }

  factory Dispositive.fromMap(Map<String, dynamic> json) => Dispositive(
    imei: json["imei"],
    model: json["model"],
    brand: json["brand"],
    version: json["version"],
    versionSystem: json["versionSystem"],
  );

  Map<String, dynamic> toMap() => {
    "imei": imei,
    "model": model,
    "brand": brand,
    "version": version,
    "versionSystem": versionSystem,
  };
}