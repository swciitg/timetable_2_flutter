import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../globals/myColors.dart';
import '../globals/sizeConfig.dart';

class SlotFieldItem extends StatelessWidget {
  final HeroIcons icon;
  final String title;

  SlotFieldItem({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          HeroIcon(
            icon,
            color: kGrey,
          ),
          SizedBox(width: SizeConfig.screenWidth * 0.07),
          Text(
            title,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
