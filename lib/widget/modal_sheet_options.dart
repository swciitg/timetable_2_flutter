import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

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
          vertical: 15,
        ),
        child: Row(
          children: [
            HeroIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          listTile(
            HeroIcons.academicCap,
            "Class",
            context,
            () {
              Navigator.of(context).pop();
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (ctx) => AddSlot(),
              );
            },
          ),
          listTile(
            HeroIcons.terminal,
            "Assignment",
            context,
            () {
              Navigator.of(context).pop();
            },
          ),
          listTile(
            HeroIcons.paperClip,
            "Quiz",
            context,
            () {
              Navigator.of(context).pop();
            },
          ),
          listTile(
            HeroIcons.calculator,
            "Lab",
            context,
            () {
              Navigator.of(context).pop();
            },
          ),
          listTile(
            HeroIcons.chatAlt2,
            "Viva",
            context,
            () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
