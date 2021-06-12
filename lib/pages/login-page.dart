import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/login_store.dart';
import '../globals/sizeConfig.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'login-page';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg_triangle.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Timetable\n",
                          style: MyFonts.bold.factor(15),
                          children: [
                            TextSpan(
                              text: "User",
                              style: const TextStyle(color: kYellow),
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/login_illustration.png')
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.horizontalBlockSize * 5,
                    vertical: SizeConfig.verticalBlockSize * 4,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kYellow,
                      onPrimary: kBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      loginStore.signInWithMicrosoft(context);
                    },
                    child: FittedBox(
                      child: Text(
                        "LOGIN WITH OUTLOOK",
                        style: MyFonts.medium.factor(7.5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
