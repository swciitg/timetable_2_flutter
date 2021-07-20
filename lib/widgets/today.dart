import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../functions/func.dart';
import '../stores/login_store.dart';
import '../stores/database.dart';
import '../globals/MyFonts.dart';
import '../globals/MySpaces.dart';
import '../globals/MyColors.dart';
import './timetable_item.dart';

class Today extends StatelessWidget {
  Timestamp time(Duration days) {
    final time = Timestamp.fromDate(DateTime.utc(
        DateTime.now().year,
        DateTime.now().add(days).month,
        DateTime.now().add(days).day,
        -5,
        -30,
        0));
    return time;
  }

  Widget classAndLabs(BuildContext context, DocumentReference db, String type) {
    return StreamBuilder(
      stream: db
          .collection(type)
          .where('status', isEqualTo: 'approved')
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              MySpaces.vSmallGapInBetween,
              Center(child: Text("Something got wrong while fetching $type")),
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading..."));
        }
        return Column(
          children: filter(snapshot.data.docs).map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data();
            return TimetableItem(data: data, type: type);
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      String rollNumber = loginStore.userData['rollNumber'];
      Map<String, String> userData = getUserData(rollNumber);
      final DocumentReference _db = FirebaseFirestore.instance
          .collection('Timetable')
          .doc(userData['programName'])
          .collection('First Year')
          .doc('Semester 2')
          .collection(userData['departmentName'])
          .doc('Group 1');
      return Container(
        width: double.infinity,
        child: Column(
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
            // Classes and Labs
            ...["Class", "Lab"].map((elem) {
              return classAndLabs(context, _db, elem);
            }),

            StreamBuilder(
              stream: _db
                  .collection('Quiz')
                  .where('status', isEqualTo: 'approved')
                  .where('time',
                      isGreaterThanOrEqualTo: time(Duration(days: 0)),
                      isLessThanOrEqualTo: time(Duration(days: 10)))
                  .orderBy('time')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      MySpaces.vSmallGapInBetween,
                      Center(
                          child: Text(
                              "Something got wrong while fetching Quizzes")),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading..."));
                }
                return Consumer<Database>(builder: (_, db, __) {
                  return Column(
                    children: db
                        .setQuizzes(snapshot.data.docs)
                        .map((Map<String, dynamic> data) {
                      return TimetableItem(data: data, type: "Quiz");
                    }).toList(),
                  );
                });
              },
            ),
            StreamBuilder(
              stream: _db
                  .collection('Viva')
                  .where('status', isEqualTo: 'approved')
                  .where('time',
                      isGreaterThanOrEqualTo: time(Duration(days: 0)),
                      isLessThanOrEqualTo: time(Duration(days: 10)))
                  .orderBy('time')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      MySpaces.vSmallGapInBetween,
                      Center(
                          child:
                              Text("Something got wrong while fetching Vivas")),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading..."));
                }
                return Consumer<Database>(builder: (_, db, __) {
                  return Column(
                    children: db
                        .setViva(snapshot.data.docs)
                        .map((Map<String, dynamic> data) {
                      return TimetableItem(data: data, type: "Viva");
                    }).toList(),
                  );
                });
              },
            ),
            StreamBuilder(
              stream: _db
                  .collection('Assignment')
                  .where('status', isEqualTo: 'approved')
                  .where('deadline',
                      isGreaterThanOrEqualTo: time(Duration(days: 0)),
                      isLessThanOrEqualTo: time(Duration(days: 7)))
                  .orderBy('deadline')
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      MySpaces.vSmallGapInBetween,
                      Center(
                        child: Text(
                            "Something got wrong while fetching Assignments"),
                      ),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading..."));
                }
                return Consumer<Database>(builder: (_, db, __) {
                  return Column(
                    children: db
                        .setAssignments(snapshot.data.docs)
                        .map((Map<String, dynamic> data) {
                      return TimetableItem(data: data, type: "Assignment");
                    }).toList(),
                  );
                });
              },
            ),
          ],
        ),
      );
    });
  }
}
