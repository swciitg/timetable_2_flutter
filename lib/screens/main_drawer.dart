import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("timetable."),
            automaticallyImplyLeading: false,
          ),
          Center(
            child: Text("Content goes here"),
          ),
        ],
      ),
    );
  }
}
