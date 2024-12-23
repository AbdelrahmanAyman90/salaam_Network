class QuranModel {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  List<Ayahs>? ayahs;

  QuranModel(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType,
      this.ayahs});

  QuranModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    if (json['ayahs'] != null) {
      ayahs = <Ayahs>[];
      json['ayahs'].forEach((v) {
        ayahs!.add(new Ayahs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['englishNameTranslation'] = this.englishNameTranslation;
    data['revelationType'] = this.revelationType;
    if (this.ayahs != null) {
      data['ayahs'] = this.ayahs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ayahs {
  int? number;
  String? text;
  String? tafseer;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;

  Ayahs({
    this.number,
    this.text,
    this.tafseer,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
  });

  Ayahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    tafseer = json['tafseer'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['text'] = this.text;
    data['tafseer'] = this.tafseer;
    data['numberInSurah'] = this.numberInSurah;
    data['juz'] = this.juz;
    data['manzil'] = this.manzil;
    data['page'] = this.page;
    data['ruku'] = this.ruku;
    data['hizbQuarter'] = this.hizbQuarter;
    return data;
  }
}
