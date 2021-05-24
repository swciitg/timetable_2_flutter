import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SlotPageHeader extends StatelessWidget {
  final HeroIcons icon;
  final String heading;

  SlotPageHeader({
    this.icon,
    this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Color.fromRGBO(229, 229, 229, 1),
      ),
      child: Row(
        children: [
          HeroIcon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            heading,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
