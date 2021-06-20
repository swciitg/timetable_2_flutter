import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './marquee.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../globals/SizeConfig.dart';
import '../globals/MySpaces.dart';

class TimetableItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final String type;
  final bool events;
  TimetableItem({this.data, this.type, this.events = false});

  Color get sideColor {
    if (type == "Class" || type == "Lab") {
      return kBlue;
    } else {
      switch (type) {
        case "Assignment":
          return kBlack;
          break;
        default:
          return kYellow;
          break;
      }
    }
  }

  String get time {
    String time;
    if (type == "Class" || type == "Lab") {
      final List<dynamic> slots = data['slots'];
      slots.forEach((elem) {
        if (elem['day'] == DateFormat.EEEE().format(DateTime.now())) {
          time = elem['time'];
        }
      });
    }

    if (type == "Quiz" || type == "Assignment" || type == "Viva") {
      String mapKey = (type == "Assignment") ? 'deadline' : 'time';
      String minutes = DateFormat().add_m().format(data[mapKey].toDate());

      if (minutes == '0') {
        time = DateFormat("h a").format(data[mapKey].toDate()).toLowerCase();
      } else {
        time = DateFormat("h:mm a").format(data[mapKey].toDate()).toLowerCase();
      }
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (events && type == "Viva")
          Column(
            children: [
              MySpaces.vGapInBetween,
              Text(
                "${DateFormat("dd").format(DateTime.parse(data['time'].toDate().toString()))}-${DateFormat("dd MMMM").format(DateTime.parse(data['finalDate'].toDate().toString()))}",
                style: MyFonts.medium.setColor(kGrey),
              ),
              MySpaces.vGapInBetween,
            ],
          ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border:
                Border.all(color: Color.fromRGBO(230, 232, 233, 1), width: 1),
          ),
          width: double.infinity,
          height: 80,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            borderOnForeground: true,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                      colors: [sideColor, Color.fromRGBO(250, 252, 255, 1)],
                      stops: [0.035, 0.035])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.horizontalBlockSize * 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${data['code']}",
                          style: MyFonts.bold.tsFactor(20),
                        ),
                        Container(
                          width: SizeConfig.horizontalBlockSize * 45,
                          child: MarqueeWidget(
                            child: RichText(
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                text: "${data['tag']}",
                                style:
                                    MyFonts.medium.setColor(kGrey).tsFactor(13),
                                children: [
                                  TextSpan(
                                    text: " . ",
                                    style: MyFonts.extraBold
                                        .setColor(kBlue)
                                        .tsFactor(25),
                                  ),
                                  TextSpan(
                                    text: "${data['platform']}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: SizeConfig.horizontalBlockSize * 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$time",
                          style: MyFonts.bold.tsFactor(22),
                        ),
                        MySpaces.vGapInBetween,
                        Text(
                          "${data['duration'] ?? "due date"}",
                          style: MyFonts.medium.tsFactor(16).setColor(kGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
