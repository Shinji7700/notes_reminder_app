/// [DateTime] extension methods
extension DateTimeExtension on DateTime {
  /// to check if date is same as [dateTime]
  bool isSameDate(DateTime dateTime) {
    return day == dateTime.day &&
        month == dateTime.month &&
        year == dateTime.year;
  }

  /// to check if date is same time as [dateTime]
  bool isSameTime(DateTime dateTime) {
    return hour == dateTime.hour && minute == dateTime.minute;
  }
}
