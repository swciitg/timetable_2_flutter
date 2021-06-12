import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../stores/classes.dart';
import '../stores/labs.dart';
import '../stores/quizzes.dart';
import '../stores/viva.dart';
import '../stores/assignment.dart';
import '../globals/MyFonts.dart';
import '../globals/MySpaces.dart';
import '../globals/MyColors.dart';
import './timetable_item.dart';

class Today extends StatelessWidget {
  final TimeOfDay time = TimeOfDay(hour: 4, minute: 15);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today",
          style: MyFonts.bold.tsFactor(25),
        ),
        MySpaces.vSmallGapInBetween,
        Text(
          DateFormat("dd MMMM").format(DateTime.now()),
          style: MyFonts.medium.setColor(kGrey),
        ),
        MySpaces.vGapInBetween,
        Consumer<Classes>(
          builder: (ctx, classes, _) {
            if (classes.todaysClasses.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                ...classes.todaysClasses.map((cl) {
                  return TimetableItem(
                    cl: cl,
                  );
                }).toList()
              ],
            );
          },
        ),
        Consumer<Labs>(
          builder: (ctx, labs, _) {
            if (labs.todaysLabs.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                ...labs.todaysLabs.map((cl) {
                  return TimetableItem(cl: cl);
                }).toList()
              ],
            );
          },
        ),
        Consumer<Quizzes>(
          builder: (ctx, quiz, _) {
            if (quiz.todaysQuizzes.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                ...quiz.todaysQuizzes.map((quiz) {
                  return TimetableItem(
                    quiz: quiz,
                  );
                }).toList()
              ],
            );
          },
        ),
        Consumer<Viva>(
          builder: (ctx, viva, _) {
            if (viva.todaysViva.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                ...viva.todaysViva.map((viva) {
                  return TimetableItem(
                    quiz: viva,
                  );
                }).toList()
              ],
            );
          },
        ),
        Consumer<Assignment>(
          builder: (ctx, ass, _) {
            if (ass.todaysAssignment.isEmpty) {
              return Container();
            }
            return Column(
              children: [
                ...ass.todaysAssignment.map((viva) {
                  return TimetableItem(
                    quiz: viva,
                  );
                }).toList()
              ],
            );
          },
        ),
      ],
    );
  }
}
