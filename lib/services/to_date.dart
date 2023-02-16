import 'package:innon/resources/app_internal_variable_const.dart';

String toDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}

String toDayMonthShort(DateTime date) {
  var mon = date.month;
  return '${date.day} ${AppVariables.months_short[mon - 1]}';
}

String toMonthTime(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  var mon = date.month;
  return '${date.day} ${AppVariables.months_short[mon - 1]}, $hour:$minute';
}

String toMonthTimeFull(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  var mon = date.month;
  return '${date.day} ${AppVariables.months[mon - 1].toString().toLowerCase()}, $hour:$minute';
}

String toMonthSingleDate(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  var mon = date.month;
  return '${date.day} ${AppVariables.months[mon - 1]} ${date.year} • $hour:$minute';
}

String toMonthDateWithTime(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  var mon = date.month;
  return '${date.day} ${AppVariables.months[mon - 1]} • $hour:$minute';
}

String toMonthDate(DateTime dates) {
  var mon = dates.month;
  return '${dates.day} ${AppVariables.months[mon - 1]}';
}

String toMonthShort(DateTime dates) {
  var mon = dates.month;
  return '${AppVariables.months_short[mon - 1]}';
}

String toMonthDates(DateTime date1, DateTime date2) {
  if (date1.day == date2.day) {
    var mon = date1.month;
    return '${date1.day} ${AppVariables.months[mon - 1]}';
  } else if (date1.month == date2.month) {
    var mon1 = date1.month;
    var mon2 = date2.month;
    return '${date1.day} - ${date2.day} ${AppVariables.months[mon1 - 1]}';
  } else {
    var mon1 = date1.month;
    var mon2 = date1.month;
    return '${date1.day} ${AppVariables.months[mon1 - 1]} - ${date2.day} ${AppVariables.months[mon2 - 1]} ';
  }
}
