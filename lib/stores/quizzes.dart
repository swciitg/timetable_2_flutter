import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class Quizzes with ChangeNotifier {
  List<Quiz> _listOfQuizzes = [
    Quiz(
      type: "Quiz",
      code: "MA102",
      duration: Duration(hours: 1, minutes: 30),
      tag: "Subjective",
      platform: "MS Teams",
      time: TimeOfDay(hour: 19, minute: 30),
      initialDate: DateTime.now(),
    ),
    Quiz(
      type: "Quiz",
      code: "PH110",
      duration: Duration(hours: 1, minutes: 0),
      tag: "Objective",
      platform: "Codetantra",
      time: TimeOfDay(hour: 16, minute: 0),
      initialDate: DateTime.now().add(Duration(days: 7)),
    ),
    Quiz(
      type: "Quiz",
      code: "BT101",
      duration: Duration(hours: 0, minutes: 39),
      tag: "Objective",
      platform: "CodeTantra",
      time: TimeOfDay(hour: 17, minute: 0),
      initialDate: DateTime.now(),
    ),
    Quiz(
      type: "Quiz",
      code: "PH102",
      duration: Duration(hours: 1, minutes: 0),
      tag: "Objective",
      platform: "Codetantra",
      time: TimeOfDay(hour: 18, minute: 0),
      initialDate: DateTime.now(),
    ),
    Quiz(
      type: "Quiz",
      code: "MA102",
      duration: Duration(hours: 1, minutes: 0),
      tag: "Subjective",
      platform: "MS Teams",
      time: TimeOfDay(hour: 11, minute: 30),
      initialDate: DateTime.now().add(Duration(days: 2)),
    ),
  ];

  List<Quiz> get listOfQuizzes {
    return [..._listOfQuizzes];
  }

  List<Quiz> get todaysQuizzes {
    List<Quiz> finalList = [];
    _listOfQuizzes.forEach((quiz) {
      if (DateFormat("dd MMMM").format(quiz.initialDate) ==
              DateFormat("dd MMMM").format(DateTime.now()) &&
          toDouble(TimeOfDay.now()) <=
              toDouble(quiz.time.add(
                  hour: quiz.duration.inHours,
                  minute: quiz.duration.inMinutes.remainder(60)))) {
        if (!finalList.contains(quiz)) {
          finalList.add(quiz);
        }
      }
    });
    finalList.sort((a, b) => toDouble(a.time) < toDouble(b.time) ? 0 : 1);
    return finalList;
  }

  SplayTreeMap<dynamic, dynamic> get upcomingQuizzes {
    final DateTime time = DateTime.now();
    Map<dynamic, dynamic> finalMap = {};
    _listOfQuizzes.forEach((quiz) {
      if (quiz.initialDate.isBefore(time.add(Duration(days: 15))) &&
          quiz.initialDate.isAfter(time.add(Duration(days: 1)))) {
        var date = DateFormat("dd MMMM yyyy").format(quiz.initialDate);
        if (!finalMap.containsKey(date)) {
          finalMap[date] = [quiz];
        } else if (finalMap.containsKey(date)) {
          finalMap[date].add(quiz);
        }
      }
    });
    var sortedMap =
        SplayTreeMap.from(finalMap, (key1, key2) => key1.compareTo(key2));
    return sortedMap;
  }

  void addQuiz(Quiz quiz) {
    if (!_listOfQuizzes.contains(quiz)) {
      _listOfQuizzes.add(quiz);
    }
    notifyListeners();
  }
}
