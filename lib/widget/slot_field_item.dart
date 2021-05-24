import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SlotFieldItem extends StatelessWidget {
  final HeroIcons icon;
  final String title;

  SlotFieldItem({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Expanded(
      child: Row(
        children: [
          HeroIcon(
            icon,
            color: Theme.of(context).indicatorColor,
          ),
          SizedBox(width: mediaQuery.size.width * 0.07),
          Text(
            title,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
