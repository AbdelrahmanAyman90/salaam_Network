import 'package:intl/intl.dart';

String getDate(int day) {
  String currentDate =
      DateFormat("dd-MM-yyyy").format(DateTime.now().add(Duration(days: day)));
  return currentDate;
}
