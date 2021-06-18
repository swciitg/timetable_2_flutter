import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './timetable_item.dart';
import './upcoming_event_date.dart';
import '../globals/mySpaces.dart';
import '../stores/database.dart';
import '../globals/MyFonts.dart';

class UpcomingEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer<Database>(
            builder: (_, db, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (db.upcomingQuizzes.values.isNotEmpty) ...[
                    Text(
                      "Upcoming Quizzes",
                      style: MyFonts.bold.tsFactor(25),
                    ),
                    MySpaces.vSmallestGapInBetween,
                  ],
                  ...db.upcomingQuizzes.values.map(
                    (list) {
                      return UpcomingEventDate(
                        data: list,
                        type: "Quiz",
                      );
                    },
                  ),
                ],
              );
            },
          ),
          Consumer<Database>(
            builder: (_, db, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (db.upcomingQuizzes.values.isEmpty &&
                      db.upcomingViva.isNotEmpty) ...[
                    Text(
                      "Upcoming Quizzes",
                      style: MyFonts.bold.tsFactor(25),
                    ),
                    MySpaces.vSmallestGapInBetween,
                  ],
                  ...db.upcomingViva.map(
                    (viva) {
                      return TimetableItem(
                        data: viva,
                        type: "Viva",
                        events: true,
                      );
                    },
                  ),
                ],
              );
            },
          ),
          MySpaces.vSmallestGapInBetween,
          Consumer<Database>(
            builder: (_, db, __) {
              if (db.upcomingAssignments.isEmpty) {
                return Container();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MySpaces.vMediumGapInBetween,
                  Text(
                    "Upcoming Assignments",
                    style: MyFonts.bold.tsFactor(25),
                  ),
                  MySpaces.vSmallestGapInBetween,
                  ...db.upcomingAssignments.values.map(
                    (list) {
                      return UpcomingEventDate(
                        data: list,
                        type: "Assignment",
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
