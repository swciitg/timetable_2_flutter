import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timetable_2_demo/globals/myColors.dart';
import 'package:timetable_2_demo/globals/sizeConfig.dart';

class NoInternet extends StatefulWidget {
  final double height;
  NoInternet({this.height});
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: widget.height,
      alignment: Alignment.bottomCenter,
      color: kBlue,
      child: Lottie.asset(
        'assets/images/no-internet.json',
        repeat: true,
        reverse: true,
        animate: true,
      ),
    );
  }
}
