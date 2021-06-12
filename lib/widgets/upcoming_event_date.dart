import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetable_2_demo/globals/mySpaces.dart';

import './timetable_item.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../models/quiz.dart';

class UpcomingEventDate extends StatelessWidget {
  final List<Quiz> quizzes;
  UpcomingEventDate(this.quizzes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MySpaces.vGapInBetween,
        Text(
          DateFormat("dd MMMM").format(quizzes[0].initialDate),
          style: MyFonts.medium.setColor(kGrey),
        ),
        MySpaces.vGapInBetween,
        ...quizzes.map((quiz) {
          return TimetableItem(quiz: quiz);
        }).toList(),
      ],
    );
  }
}
