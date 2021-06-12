import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './upcoming_event_date.dart';
import '../stores/assignment.dart';
import '../globals/mySpaces.dart';
import '../stores/quizzes.dart';
import '../stores/viva.dart';
import '../globals/MyFonts.dart';
import './timetable_item.dart';
// import '../globals/MyColors.dart';

class UpcomingEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<Quizzes>(
            builder: (ctx, quiz, _) {
              if (quiz.upcomingQuizzes.values.isEmpty) {
                return Container();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Quizzes",
                    style: MyFonts.bold.tsFactor(25),
                  ),
                  MySpaces.vSmallestGapInBetween,
                  ...quiz.upcomingQuizzes.values.map((quizzes) {
                    return UpcomingEventDate(quizzes);
                  }).toList(),
                ],
              );
            },
          ),
          Consumer<Viva>(
            builder: (ctx, viva, _) {
              if (viva.upcomingViva.isEmpty) {
                return Container();
              }
              return Column(
                children: [
                  ...viva.upcomingViva.map((viva) {
                    return TimetableItem(
                      quiz: viva,
                      events: true,
                    );
                  }).toList(),
                ],
              );
            },
          ),
          MySpaces.vSmallestGapInBetween,
          Consumer<Assignment>(
            builder: (ctx, ass, _) {
              if (ass.upcomingAssignment.isEmpty) {
                return Container();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MySpaces.vMediumGapInBetween,
                  Text(
                    "Upcoming Assignment",
                    style: MyFonts.bold.tsFactor(25),
                  ),
                  ...ass.upcomingAssignment.values.map((ass) {
                    return UpcomingEventDate(ass);
                  }).toList(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
