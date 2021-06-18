import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../globals/mySpaces.dart';
import './timetable_item.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';

class UpcomingEventDate extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String type;
  UpcomingEventDate({this.data, this.type});
  @override
  Widget build(BuildContext context) {
    String mapKey = (type == "Quiz") ? 'time' : 'deadline';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MySpaces.vGapInBetween,
        Text(
          DateFormat("dd MMMM")
              .format(DateTime.parse(data[0][mapKey].toDate().toString())),
          style: MyFonts.medium.setColor(kGrey),
        ),
        MySpaces.vGapInBetween,
        ...data.map((quiz) {
          return TimetableItem(data: quiz, type: type);
        }).toList(),
      ],
    );
  }
}
