import 'package:flutter/material.dart';
import 'package:timetable_2_demo/globals/mySpaces.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';
import '../globals/mySpaces.dart';
import '../globals/sizeConfig.dart';

class PowerUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String message = 'Powering up servers at CSE Department!';
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_internet_illustration.png'),
          MySpaces.vLargeGapInBetween,
          Text(
            message,
            textAlign: TextAlign.center,
            style: MyFonts.medium.setColor(kGrey).factor(4.39),
          ),
        ],
      ),
    );
  }
}
