class Reserve {
  String? day;
  String? hourInitial;
  String? hourFinish;

  Reserve({this.day, this.hourInitial, this.hourFinish});

  @override
  String toString() {
    return 'Reserve{day: $day, hourInitial: $hourInitial, hourFinish: $hourFinish}';
  }

  factory Reserve.fromMap(Map<String, dynamic> json) => Reserve(
      day: json['day'],
      hourInitial: json["hour_initial"],
      hourFinish: json["hour_finish"]);

  Map<String, dynamic> toMap() =>
      {"day": day, "hour_initial": hourInitial, "hour_finish": hourFinish};
}
