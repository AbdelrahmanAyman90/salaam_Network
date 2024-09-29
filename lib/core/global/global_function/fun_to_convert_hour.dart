String convertToArabicAmPm(String time) {
  try {
    // Check if the time string is valid
    if (time.isEmpty || !time.contains(':')) {
      throw FormatException('Invalid time format');
    }

    // Split the time string (e.g., "14:30") into hours and minutes
    List<String> timeParts = time.split(':');

    // Ensure both hour and minute parts are valid
    if (timeParts.length != 2 || timeParts[0].isEmpty || timeParts[1].isEmpty) {
      throw FormatException('Invalid time format');
    }

    int hour = int.parse(timeParts[0]);
    String minutes = timeParts[1];

    // Determine if it's AM or PM
    String period = hour < 12 ? "ص" : "م";

    // Convert to 12-hour format
    if (hour == 0) {
      hour = 12; // Midnight case
    } else if (hour > 12) {
      hour = hour - 12; // Convert to 12-hour time
    }

    // Return the formatted time with Arabic AM/PM
    return "$hour:$minutes $period";
  } catch (e) {
    // Log the error and return a fallback time
    print('Error in convertToArabicAmPm: $e');
    return '';
  }
}
