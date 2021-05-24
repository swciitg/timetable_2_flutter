import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:timetable/models/class_model.dart';
import 'package:timetable/widget/tags_list.dart';

import '../models/slot.dart';

class TimetableItem extends StatelessWidget {
  final ClassModel cl;
  TimetableItem(this.cl);

  String get duration {
    int minutes = cl.duration.inMinutes;
    int hours = cl.duration.inHours;
    minutes = minutes - (hours * 60);
    if (minutes == 0) {
      return "$hours hour";
    } else {
      return "$hours hour $minutes min";
    }
  }

  String get time {
    Slot classSlot;
    cl.slots.forEach((slot) {
      if (slot.day == DateFormat.EEEE().format(DateTime.now())) {
        classSlot = slot;
      }
    });
    TimeOfDay slotTime = classSlot.time;
    String timeMode = slotTime.periodOffset == 0 ? "am" : "pm";
    int hours = (slotTime.hour - slotTime.periodOffset) == 0
        ? 12
        : slotTime.hour - slotTime.periodOffset;
    String minutes =
        (slotTime.minute < 10) ? "0${slotTime.minute}" : "${slotTime.minute}";
    return "$hours : $minutes $timeMode";
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final tsFactor = mediaQuery.textScaleFactor;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 1,
      ),
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Montserrat'),
        child: Card(
          elevation: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 10,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Container(
                      margin:
                          EdgeInsets.only(left: mediaQuery.size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${cl.code}",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: tsFactor * 20,
                            ),
                          ),
                          TagsList(cl.tags),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$time",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: tsFactor * 22,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "$duration",
                          style: TextStyle(
                            fontSize: tsFactor * 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
