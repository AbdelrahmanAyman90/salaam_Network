import 'package:intl/intl.dart';

String reminTime(String time) {
  DateFormat timeFormat = DateFormat("HH:mm");
  DateTime now = DateTime.now();

  // Parse the target time as if it were today
  DateTime parsedTime = timeFormat.parse(time);
  DateTime targetDateTime = DateTime(
      now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

  // Calculate the difference
  Duration difference = targetDateTime.difference(now);

  // Check if the target time is in the past for today and adjust to next day if necessary
  if (difference.isNegative) {
    targetDateTime = targetDateTime.add(Duration(days: 1));
    difference = targetDateTime.difference(now);
  }

  // Extract hours, minutes, and seconds
  String hours = difference.inHours.toString().padLeft(2, '0');
  String minutes =
      difference.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds =
      difference.inSeconds.remainder(60).toString().padLeft(2, '0');

  // log("------------");
  // log("Hours: $hours");
  // log("Minutes: $minutes");
  // log("Seconds: $seconds");

  return "$hours:$minutes:$seconds";
}
