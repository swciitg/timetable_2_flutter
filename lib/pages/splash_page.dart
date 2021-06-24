import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_demo/pages/no-internet.dart';

import './home_page.dart';
import './login-page.dart';
import '../stores/login_store.dart';
import '../globals/myFonts.dart';
import '../globals/myColors.dart';
import '../globals/sizeConfig.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool noInternet = false;
  Future<void> checkUserStatus() {
    return Provider.of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then(
      (result) {
        if (result) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomePage.routeName, (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LoginPage.routeName, (Route<dynamic> route) => false);
        }
      },
    ).catchError((error) {
      setState(() {
        noInternet = true;
      });
    });
  }

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double height =
        SizeConfig.screenHeight - SizeConfig.mediaQueryData.padding.top;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: checkUserStatus,
        child: ListView(
          children: [
            if (noInternet) NoInternet(height: height),
            if (!noInternet)
              Container(
                height: height,
                color: kBlue,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Timetable",
                      style: MyFonts.extraBold.factor(15),
                      children: <TextSpan>[
                        TextSpan(
                          text: ".",
                          style: TextStyle(
                            color: kYellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        // child: noInternet
        //     ? Stack(
        //         children: [
        //           ListView(),
        //           NoInternet(),
        //         ],
        //       )
        //     : Container(
        //         color: kBlue,
        //         child: Center(
        //           child: RichText(
        //             text: TextSpan(
        //               text: "Timetable",
        //               style: MyFonts.extraBold.factor(15),
        //               children: <TextSpan>[
        //                 TextSpan(
        //                   text: ".",
        //                   style: TextStyle(
        //                     color: kYellow,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
      ),
    );
  }
}
