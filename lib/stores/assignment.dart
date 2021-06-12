import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/quiz.dart';

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

class Assignment with ChangeNotifier {
  List<Quiz> _listOfAssignments = [
    Quiz(
      type: "Assignment",
      code: "ME110",
      time: TimeOfDay(hour: 17, minute: 0),
      tag: "Project 1",
      platform: "MS Teams",
      initialDate: DateTime.now(),
    ),
    Quiz(
      type: "Assignment",
      code: "ME110",
      time: TimeOfDay(hour: 17, minute: 0),
      tag: "Poster",
      platform: "MS Teams",
      initialDate: DateTime.now(),
    ),
    Quiz(
      type: "Assignment",
      code: "ME110",
      time: TimeOfDay(hour: 17, minute: 0),
      tag: "Project 2",
      platform: "MS Teams",
      initialDate: DateTime.now().add(Duration(days: 3)),
    ),
  ];

  List<Quiz> get listOfAssignments {
    return [..._listOfAssignments];
  }

  List<Quiz> get todaysAssignment {
    List<Quiz> finalList = [];
    _listOfAssignments.forEach((ass) {
      if (DateFormat("dd MMMM").format(ass.initialDate) ==
              DateFormat("dd MMMM").format(DateTime.now()) &&
          toDouble(TimeOfDay.now()) <= toDouble(ass.time)) {
        if (!finalList.contains(ass)) {
          finalList.add(ass);
        }
      }
    });
    print(finalList);
    return finalList;
  }

  SplayTreeMap<dynamic, dynamic> get upcomingAssignment {
    final DateTime time = DateTime.now();
    Map<String, List<Quiz>> finalMap = {};
    _listOfAssignments.forEach((ass) {
      if (ass.initialDate.isBefore(time.add(Duration(days: 18))) &&
          ass.initialDate.isAfter(time.add(Duration(days: 1)))) {
        var date = DateFormat("dd MMMM yyyy").format(ass.initialDate);
        if (!finalMap.containsKey(date)) {
          finalMap[date] = [ass];
        } else if (finalMap.containsKey(date)) {
          finalMap[date].add(ass);
        }
      }
    });
    var sortedMap =
        SplayTreeMap.from(finalMap, (key1, key2) => key1.compareTo(key2));
    return sortedMap;
  }

  void addAssignment(Quiz ass) {
    if (!_listOfAssignments.contains(ass)) {
      _listOfAssignments.add(ass);
      notifyListeners();
    }
  }
}
