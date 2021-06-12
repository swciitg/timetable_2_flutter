import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../globals/myFonts.dart';
import '../globals/myColors.dart';
import '../globals/mySpaces.dart';

class SlotPageHeader extends StatelessWidget {
  final String heading;

  SlotPageHeader({
    this.heading,
  });
  HeroIcons get getIcon {
    switch (heading) {
      case "Class":
        return HeroIcons.academicCap;
        break;
      case "Lab":
        return HeroIcons.calculator;
        break;
      case "Assignment":
        return HeroIcons.terminal;
        break;
      case "Quiz":
        return HeroIcons.paperClip;
        break;
      case "Viva":
        return HeroIcons.chatAlt2;
        break;
      default:
        return HeroIcons.academicCap;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Color.fromRGBO(225, 231, 255, 1),
      ),
      child: Row(
        children: [
          HeroIcon(
            getIcon,
            color: kBlue,
            size: 35,
          ),
          MySpaces.hMediumGapInBetween,
          Text(
            "Add a new ${heading.toLowerCase()}",
            style: MyFonts.bold.setColor(kBlue).size(18),
          ),
        ],
      ),
    );
  }
}
