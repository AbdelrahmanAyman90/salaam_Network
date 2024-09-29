class AzkarModel {
  int? id;
  String? tittel;
  List<Data>? data;
  String? number;

  AzkarModel({this.id, this.tittel, this.data});

  AzkarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tittel = json['tittel'];
    number = json["number"];

    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tittel'] = this.tittel;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? zekr;
  int? repeat;
  String? description;

  Data({this.zekr, this.repeat, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    zekr = json['zekr'];
    repeat = json['repeat'] is String
        ? int.tryParse(json['repeat'])
        : json['repeat'] as int?;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zekr'] = this.zekr;
    data['repeat'] = this.repeat;
    data['description'] = this.description;
    return data;
  }
}
