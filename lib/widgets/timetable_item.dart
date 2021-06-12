import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './marquee.dart';
import '../models/class_model.dart';
import '../models/quiz.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../globals/SizeConfig.dart';
import '../globals/MySpaces.dart';

class TimetableItem extends StatelessWidget {
  final ClassModel cl;
  final Quiz quiz;
  final bool events;
  TimetableItem({this.cl, this.quiz, this.events = false});

  bool get isClass {
    return (cl != null);
  }

  Color get sideColor {
    if (isClass) {
      return kBlue;
    } else {
      switch (quiz.type) {
        case "Assignment":
          return kBlack;
          break;
        default:
          return kYellow;
          break;
      }
    }
  }

  String get duration {
    if (!isClass && quiz.type == "Assignment") {
      return "due date";
    }
    double minutes = isClass
        ? cl.duration.inMinutes.toDouble()
        : quiz.duration.inMinutes.toDouble();
    double hours = isClass
        ? cl.duration.inHours.toDouble()
        : quiz.duration.inHours.toDouble();
    minutes = minutes - (hours * 60);

    if (hours == 0) {
      return "${minutes.toInt()} min";
    }
    if (minutes == 0) {
      return "${hours.toInt()} hour";
    }
    String finalHours = (hours + (minutes / 60)).toString();
    return "$finalHours hour";
  }

  String get time {
    TimeOfDay slotTime = isClass ? cl.slots.time : quiz.time;
    String timeMode = slotTime.periodOffset == 0 ? "am" : "pm";
    int hours = (slotTime.hour - slotTime.periodOffset) == 0
        ? 12
        : slotTime.hour - slotTime.periodOffset;
    String minutes =
        (slotTime.minute < 10) ? "0${slotTime.minute}" : "${slotTime.minute}";
    if (minutes == '00') {
      return "$hours $timeMode";
    }
    return "$hours : $minutes $timeMode";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (events && !isClass && quiz.type == "Viva")
          Column(
            children: [
              MySpaces.vGapInBetween,
              Text(
                "${DateFormat("dd").format(quiz.initialDate)}-${DateFormat("dd MMMM").format(quiz.finalDate)}",
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
                          "${isClass ? cl.code : quiz.code}",
                          style: MyFonts.bold.tsFactor(20),
                        ),
                        Container(
                          width: SizeConfig.horizontalBlockSize * 45,
                          child: MarqueeWidget(
                            child: RichText(
                              overflow: TextOverflow.fade,
                              text: TextSpan(
                                text: "${isClass ? cl.tag : quiz.tag}",
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
                                    text:
                                        "${isClass ? cl.platform : quiz.platform}",
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
                          "$duration",
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
