import 'package:flutter/material.dart';

import '../models/quiz.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    if (this.minute + minute >= 60) {
      return this.replacing(
          hour: this.hour + hour + 1,
          minute: (this.minute + minute).remainder(60));
    }
    return this.replacing(hour: this.hour + hour, minute: this.minute + minute);
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

class Viva with ChangeNotifier {
  List<Quiz> _listOfViva = [
    Quiz(
      type: "Viva",
      code: "ME101",
      time: TimeOfDay(hour: 15, minute: 40),
      duration: Duration(hours: 1, minutes: 30),
      tag: "Viva",
      platform: "Online",
      initialDate: DateTime.now(),
      finalDate: DateTime.now().add(Duration(days: 4)),
    ),
    Quiz(
      type: "Viva",
      code: "ME110",
      time: TimeOfDay(hour: 17, minute: 0),
      duration: Duration(hours: 0, minutes: 15),
      tag: "Viva",
      platform: "Online",
      initialDate: DateTime.now(),
      finalDate: DateTime.now().add(Duration(days: 2)),
    ),
  ];

  List<Quiz> get listOfViva {
    return [..._listOfViva];
  }

  List<Quiz> get todaysViva {
    List<Quiz> finalList = [];
    _listOfViva.forEach((viva) {
      if (viva.initialDate.isBefore(DateTime.now()) &&
          viva.finalDate.isAfter(DateTime.now()) &&
          toDouble(TimeOfDay.now()) <=
              toDouble(viva.time.add(
                  hour: viva.duration.inHours,
                  minute: viva.duration.inMinutes.remainder(60)))) {
        if (!finalList.contains(viva)) {
          finalList.add(viva);
        }
      }
    });
    return finalList;
  }

  List<Quiz> get upcomingViva {
    List<Quiz> finalList = [];
    _listOfViva.forEach((viva) {
      if (viva.initialDate.isBefore(DateTime.now().add(Duration(days: 15)))) {
        if (!finalList.contains(viva)) {
          finalList.add(viva);
        }
      }
    });
    return finalList;
  }

  void addViva(Quiz viva) {
    if (!_listOfViva.contains(viva)) {
      _listOfViva.add(viva);
      notifyListeners();
    }
  }
}
