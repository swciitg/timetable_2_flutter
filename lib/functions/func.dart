String getDays(List<String> selectedDays) {
  String returnText = '';
  if (selectedDays.isEmpty) {
    return '\"Select days\"';
  } else {
    selectedDays.forEach((day) {
      if (selectedDays.indexOf(day) == (selectedDays.length - 1)) {
        returnText += day;
      } else if (selectedDays.indexOf(day) == (selectedDays.length - 2)) {
        returnText += day + ' and ';
      } else {
        returnText += day + " , ";
      }
    });
  }
  return returnText;
}

String timeMode(time) {
  if (time.periodOffset == 0) {
    return "am";
  } else {
    return "pm";
  }
}

String minutes(time) {
  if (time.minute < 10) {
    return "0${time.minute}";
  } else {
    return '${time.minute}';
  }
}

String hours(time) {
  if (time.hour - time.periodOffset == 0) {
    return '12';
  }

  return "${time.hour - time.periodOffset}";
}

String duration(dur) {
  double minutes = dur.inMinutes.toDouble();
  double hours = dur.inHours.toDouble();
  minutes = minutes - (hours * 60);

  if (hours == 0) {
    return "${minutes.toInt()} min";
  }
  if (minutes == 0) {
    return "${hours.toInt()} hour";
  }
  String finalHours = (hours + (minutes / 60)).toString();
  return "$finalHours hour";
}
