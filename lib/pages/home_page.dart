import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/upcoming_events.dart';
import '../globals/sizeConfig.dart';
import './main_drawer.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../globals/mySpaces.dart';
import '../widgets/modal_sheet_options.dart';
import '../widgets/today.dart';

class HomePage extends StatelessWidget {
  void startAddingSlot(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Container(
          color: Colors.transparent,
          child: ModalSheetOptions(),
        );
      },
    );
  }

  static const routeName = 'home-page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "timetable",
            style: MyFonts.bold.size(25).letterSpace(0.5),
            children: [
              TextSpan(text: ".", style: TextStyle(color: kYellow)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
          child: Column(
            children: [
              Today(),
              MySpaces.vMediumGapInBetween,
              UpcomingEvents(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddingSlot(context),
        backgroundColor: kYellow,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
