class PrayModel {
  Timings? timings;
  Date? date;

  PrayModel({this.timings, this.date});

  PrayModel.fromJson(Map<String, dynamic> json) {
    timings =
        json['timings'] != null ? Timings.fromJson(json['timings']) : null;
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (timings != null) {
      data['timings'] = timings!.toJson();
    }
    if (date != null) {
      data['date'] = date!.toJson();
    }
    return data;
  }
}

class Timings {
  List<String?>? prayerTimes;

  Timings({this.prayerTimes});

  // When converting from JSON, store the values in a list
  Timings.fromJson(Map<String, dynamic> json) {
    prayerTimes = [
      json['Fajr'],
      json['Dhuhr'],
      json['Asr'],
      json['Maghrib'],
      json['Isha'],
    ];
  }

  // When converting to JSON, map the list back to the appropriate keys
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Fajr'] = prayerTimes![0];
    data['Dhuhr'] = prayerTimes![1];
    data['Asr'] = prayerTimes![2];
    data['Maghrib'] = prayerTimes![3];
    data['Isha'] = prayerTimes![4];
    return data;
  }
}

class Date {
  String? readable;
  String? ar;
  String? date;
  Date({this.readable, this.ar, this.date});

  Date.fromJson(Map<String, dynamic> json) {
    readable = json['readable'];
    ar = json["hijri"]["weekday"]['ar'];
    date = json["gregorian"]["date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['readable'] = readable;
    data['ar'] = ar;
    return data;
  }
}
