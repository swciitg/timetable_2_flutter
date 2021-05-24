import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/slot.dart';
import '../models/class_model.dart';

class Classes with ChangeNotifier {
  List<ClassModel> _listOfClasses = [
    ClassModel(
      code: "ME101",
      duration: Duration(hours: 1),
      tags: ["MS Teams", "Doubt Clearing"],
      status: Status.pending,
      slots: [
        Slot(
          day: "Monday",
          time: TimeOfDay(
            hour: 9,
            minute: 0,
          ),
        ),
        Slot(
          day: "Tuesday",
          time: TimeOfDay(
            hour: 9,
            minute: 0,
          ),
        ),
        Slot(
          day: "Wednesday",
          time: TimeOfDay(
            hour: 9,
            minute: 0,
          ),
        ),
      ],
    ),
    ClassModel(
      code: "CS101",
      duration: Duration(hours: 1, minutes: 15),
      tags: ["MS Teams", "Theory"],
      status: Status.pending,
      slots: [
        Slot(
          day: "Monday",
          time: TimeOfDay(
            hour: 11,
            minute: 0,
          ),
        ),
        Slot(
          day: "Tuesday",
          time: TimeOfDay(
            hour: 11,
            minute: 0,
          ),
        ),
        Slot(
          day: "Friday",
          time: TimeOfDay(
            hour: 10,
            minute: 0,
          ),
        ),
      ],
    ),
    ClassModel(
      code: "BT101",
      duration: Duration(hours: 1),
      tags: ["MS Teams", "Theory"],
      status: Status.pending,
      slots: [
        Slot(
          day: "Monday",
          time: TimeOfDay(
            hour: 10,
            minute: 0,
          ),
        ),
        Slot(
          day: "Thursday",
          time: TimeOfDay(
            hour: 9,
            minute: 0,
          ),
        ),
        Slot(
          day: "Friday",
          time: TimeOfDay(
            hour: 9,
            minute: 0,
          ),
        ),
      ],
    ),
    ClassModel(
      code: "MA102",
      duration: Duration(hours: 1),
      tags: ["MS Teams", "Theory"],
      status: Status.pending,
      slots: [
        Slot(
          day: "Tuesday",
          time: TimeOfDay(
            hour: 10,
            minute: 0,
          ),
        ),
        Slot(
          day: "Wednesday",
          time: TimeOfDay(
            hour: 10,
            minute: 0,
          ),
        ),
        Slot(
          day: "Thursday",
          time: TimeOfDay(
            hour: 10,
            minute: 0,
          ),
        ),
      ],
    ),
    ClassModel(
      code: "PH102",
      duration: Duration(hours: 1),
      tags: ["MS Teams", "Theory"],
      status: Status.pending,
      slots: [
        Slot(
          day: "Wednesday",
          time: TimeOfDay(
            hour: 11,
            minute: 0,
          ),
        ),
        Slot(
          day: "Thursday",
          time: TimeOfDay(
            hour: 11,
            minute: 0,
          ),
        ),
      ],
    ),
  ];

  List<ClassModel> get listOfClasses {
    return [..._listOfClasses];
  }

  List<ClassModel> get todaysClasses {
    List<ClassModel> finalList = [];
    _listOfClasses.forEach((cl) {
      cl.slots.forEach((slot) {
        if (slot.day == DateFormat.EEEE().format(DateTime.now())) {
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
      cl.slots.forEach((element) {
        _listOfClasses[index].slots.add(element);
      });
    }
    notifyListeners();
  }
}
