import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/slot.dart';
import '../models/class_model.dart';

class Classes with ChangeNotifier {
  List<ClassModel> _listOfClasses = [
    ClassModel(
      code: "ME101",
      duration: Duration(hours: 1),
      platform: "MS Teams",
      tag: "Doubt Clearing",
      status: Status.pending,
      slots: Slot(
        day: ["Monday", "Tuesday", "Wednesday"],
        time: TimeOfDay(hour: 9, minute: 0),
      ),
    ),
    ClassModel(
      code: "CS101",
      duration: Duration(hours: 1, minutes: 15),
      platform: "MS Teams",
      tag: "Doubt Clearing",
      status: Status.pending,
      slots: Slot(
        day: ["Monday", "Tuesday", "Saturday"],
        time: TimeOfDay(hour: 11, minute: 0),
      ),
    ),
    ClassModel(
      code: "CS101",
      duration: Duration(hours: 1, minutes: 15),
      platform: "MS Teams",
      tag: "Theory",
      status: Status.pending,
      slots: Slot(
        day: ["Friday"],
        time: TimeOfDay(hour: 10, minute: 0),
      ),
    ),
    ClassModel(
      code: "BT101",
      duration: Duration(hours: 1),
      platform: "MS Teams",
      tag: "Theory",
      status: Status.pending,
      slots: Slot(
        day: ["Thursday", "Friday", "Saturday"],
        time: TimeOfDay(hour: 9, minute: 0),
      ),
    ),
    ClassModel(
      code: "BT101",
      duration: Duration(hours: 1),
      platform: "MS Teams",
      tag: "Doubt Clearing",
      status: Status.pending,
      slots: Slot(
        day: ["Monday"],
        time: TimeOfDay(hour: 10, minute: 0),
      ),
    ),
    ClassModel(
      code: "MA102",
      duration: Duration(hours: 1),
      platform: "MS Teams",
      tag: "Doubt Clearing",
      status: Status.pending,
      slots: Slot(
        day: ["Tuesday", "Wednesday", "Thursday"],
        time: TimeOfDay(hour: 10, minute: 0),
      ),
    ),
    ClassModel(
      code: "PH102",
      duration: Duration(hours: 1),
      platform: "MS Teams",
      tag: "Doubt Clearing",
      status: Status.pending,
      slots: Slot(
        day: ["Wednesday", "Thursday"],
        time: TimeOfDay(hour: 11, minute: 0),
      ),
    ),
  ];

  List<ClassModel> get listOfClasses {
    return [..._listOfClasses];
  }

  List<ClassModel> get todaysClasses {
    List<ClassModel> finalList = [];
    _listOfClasses.forEach((cl) {
      cl.slots.day.forEach((day) {
        if (day == DateFormat.EEEE().format(DateTime.now())) {
          if (!finalList.contains(cl)) {
            finalList.add(cl);
          }
        }
      });
    });
    return finalList;
  }

  void addClass(ClassModel cl) {
    final index = _listOfClasses.indexWhere((elem) => cl.code == elem.code);
    if (index == -1) {
      _listOfClasses.add(cl);
    } else {
      if (_listOfClasses[index].slots.time == cl.slots.time) {
        cl.slots.day.forEach((element) {
          if (!_listOfClasses[index].slots.day.contains(element)) {
            _listOfClasses[index].slots.day.add(element);
          }
        });
      }
    }
    notifyListeners();
  }
}
