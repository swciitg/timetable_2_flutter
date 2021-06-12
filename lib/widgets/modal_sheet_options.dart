import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../globals/myColors.dart';
import '../globals/mySpaces.dart';
import '../globals/myFonts.dart';
import './add_slot.dart';

class ModalSheetOptions extends StatelessWidget {
  Widget listTile(
      HeroIcons icon, String title, BuildContext context, Function func) {
    return InkWell(
      onTap: func,
      splashColor: Colors.black45,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Row(
          children: [
            HeroIcon(
              icon,
              color: kBlue,
              size: 25,
            ),
            MySpaces.hLargeGapInBetween,
            Text(
              title,
              style: MyFonts.bold.size(22).setColor(Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> sheetOptions = [
    {
      "title": "Class",
      "icon": HeroIcons.academicCap,
    },
    {
      "title": "Assignment",
      "icon": HeroIcons.terminal,
    },
    {
      "title": "Quiz",
      "icon": HeroIcons.paperClip,
    },
    {
      "title": "Lab",
      "icon": HeroIcons.calculator,
    },
    {
      "title": "Viva",
      "icon": HeroIcons.chatAlt2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      child: Wrap(
        children: [
          ...sheetOptions.map((tile) {
            return listTile(
              tile['icon'],
              tile['title'],
              context,
              () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => AddSlot(type: tile["title"]),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
