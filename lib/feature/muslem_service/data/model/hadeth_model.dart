class HadethModel {
  String? tittel;
  String? number;
  List<HadehtData>? data;

  HadethModel({this.tittel, this.data, this.number});

  HadethModel.fromJson(Map<String, dynamic> json) {
    tittel = json['tittel'];
    number = json["number"];
    if (json['data'] != null) {
      data = <HadehtData>[];
      json['data'].forEach((v) {
        data!.add(new HadehtData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tittel'] = this.tittel;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HadehtData {
  String? description;
  String? hadith;

  HadehtData({this.description, this.hadith});

  HadehtData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    hadith = json['hadith'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['hadith'] = this.hadith;
    return data;
  }
}
