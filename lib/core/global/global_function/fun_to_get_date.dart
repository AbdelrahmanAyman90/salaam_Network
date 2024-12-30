import 'package:intl/intl.dart';

String getDate(int day) {
  String currentDate = DateFormat('dd-MM-yyyy', 'en')
      .format(DateTime.now().add(Duration(days: day)));
  return currentDate;
}
