import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_demo/widgets/power_up.dart';

import '../stores/login_store.dart';
import '../globals/sizeConfig.dart';
import '../globals/myColors.dart';
import '../globals/myFonts.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool buttonPressed = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          body: buttonPressed
              ? PowerUp()
              : Column(
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
                          onPressed: () async {
                            setState(() {
                              buttonPressed = true;
                            });
                            await loginStore
                                .signInWithMicrosoft(context)
                                .catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login Failed")));
                              setState(() {
                                buttonPressed = false;
                              });
                            });
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
