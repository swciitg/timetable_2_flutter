import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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

List<QueryDocumentSnapshot> filter(List<QueryDocumentSnapshot> documents) {
  bool isToday = false;
  var finalList = documents.where((doc) {
    isToday = false;
    doc.data()['slots'].forEach((elem) {
      if (elem['day'] == DateFormat.EEEE().format(DateTime.now())) {
        isToday = true;
      }
    });
    return isToday;
  }).toList();

  return finalList;
}

Map<String, String> getUserData(String rN) {
  Map<String, String> finalMap = {};
  String department;
  String program;
  int rollNum = int.tryParse(rN);
  int departmentCode = (rollNum ~/ 1000) % 100;
  int programCode = (rollNum ~/ 100000) % 100;

  switch (departmentCode) {
    case 1:
      department = "CSE";
      break;
    case 2:
      department = "ECE";
      break;
    case 3:
      department = "ME";
      break;
    case 4:
      department = "CE";
      break;
    case 5:
      department = "DD";
      break;
    case 6:
      department = "BT";
      break;
    case 7:
      department = "CL";
      break;
    case 8:
      department = "EEE";
      break;
    case 21:
      department = "EPH";
      break;
    case 22:
      department = "CST";
      break;
    case 23:
      department = "MnC";
      break;
  }

  switch (programCode) {
    case 1:
      program = "B.Tech";
      break;
    case 2:
      program = "B.Des";
      break;
    case 41:
      program = "M.Tech";
      break;
    case 61:
      program = "PhD";
      break;
    default:
  }

  finalMap = {
    'departmentName': department,
    'programName': program,
  };

  return finalMap;
}
