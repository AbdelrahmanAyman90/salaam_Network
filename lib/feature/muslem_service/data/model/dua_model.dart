class DuaModel {
  String? zekr;
  String? description;
  int? repeat;

  DuaModel({this.zekr, this.description, this.repeat});

  DuaModel.fromJson(Map<String, dynamic> json) {
    zekr = json['zekr'];
    repeat = json['repeat'];

    description = json['description'];
  }
}
