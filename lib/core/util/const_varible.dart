import 'package:intl/intl.dart';

class PrayerName {
  final String arabic;
  final String english;

  PrayerName({required this.arabic, required this.english});
}

// List of prayers with both Arabic and English names
List<PrayerName> praysName = [
  PrayerName(arabic: "صلاه الفجر", english: "Fajr"),
  PrayerName(arabic: "صلاه الظهر", english: "Dhuhr"),
  PrayerName(arabic: "صلاه العصر", english: "Asr"),
  PrayerName(arabic: "صلاه المغرب", english: "Maghrib"),
  PrayerName(arabic: "صلاه العشاء", english: "Isha"),
];

DateFormat timeFormat = DateFormat("HH:mm", 'en');
