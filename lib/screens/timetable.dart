import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:timetable/models/class_model.dart';
import '../widget/modal_sheet_options.dart';
import '../widget/timetable_item.dart';
import 'package:provider/provider.dart';

import './main_drawer.dart';
import '../Providers/classes.dart';

class Timetable extends StatelessWidget {
  void startAddingSlot(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return ModalSheetOptions();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final tsFactor = mediaQuery.textScaleFactor;
    final data = Provider.of<Classes>(context);
    final List<ClassModel> classesToday = data.todaysClasses;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "timetable",
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
            children: <TextSpan>[
              TextSpan(
                text: ".",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(mediaQuery.size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  "Today",
                  style: TextStyle(
                    fontSize: tsFactor * 23,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  DateFormat("dd MMMM").format(DateTime.now()),
                  style: TextStyle(
                    fontSize: tsFactor * 19,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
              ),
              ...classesToday.map((cl) {
                return TimetableItem(cl);
              }).toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddingSlot(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
