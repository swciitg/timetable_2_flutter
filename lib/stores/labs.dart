import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/slot.dart';
import '../models/class_model.dart';

class Labs with ChangeNotifier {
  List<ClassModel> _listOfLabs = [
    ClassModel(
      code: "ME110",
      duration: Duration(hours: 0, minutes: 45),
      slots: Slot(
        day: ["Tuesday"],
        time: TimeOfDay(hour: 16, minute: 15),
      ),
      tag: "Lab",
      platform: "MS Teams",
    ),
    ClassModel(
      code: "CS110",
      duration: Duration(hours: 3, minutes: 0),
      slots: Slot(
        day: ["Thursday"],
        time: TimeOfDay(hour: 14, minute: 0),
      ),
      tag: "Lab",
      platform: "MS Teams",
    ),
    ClassModel(
      code: "EE102",
      duration: Duration(hours: 3),
      slots: Slot(
        day: ["Saturday"],
        time: TimeOfDay(hour: 14, minute: 0),
      ),
      tag: "Lab",
      platform: "MS Teams",
    ),
  ];

  List<ClassModel> get listOfLabs {
    return [..._listOfLabs];
  }

  List<ClassModel> get todaysLabs {
    List<ClassModel> finalList = [];
    _listOfLabs.forEach((lab) {
      lab.slots.day.forEach((day) {
        if (day == DateFormat.EEEE().format(DateTime.now())) {
          if (!finalList.contains(lab)) {
            finalList.add(lab);
          }
        }
      });
    });
    return finalList;
  }

  void addLabs(ClassModel lab) {
    if (!_listOfLabs.contains(lab)) {
      _listOfLabs.add(lab);
      notifyListeners();
    }
  }
}
