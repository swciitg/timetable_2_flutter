import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_demo/stores/login_store.dart';

class HomePage extends StatefulWidget {
  static String id = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        User currentUser = loginStore.firebaseUser;
        String name = loginStore.userData['displayName'];
        String degree = loginStore.userData['jobTitle'];
        String rollNumber = loginStore.userData['rollNumber'];
        return Scaffold(
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://image.flaticon.com/icons/png/512/732/732221.png'),
                    radius: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    name,
                    style: GoogleFonts.rubik(
                      height: 1.5,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    degree,
                    style: GoogleFonts.rubik(
                      height: 1.5,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    rollNumber,
                    style: GoogleFonts.rubik(
                      height: 1.5,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    currentUser.email,
                    style: GoogleFonts.rubik(
                      height: 1.5,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    currentUser.uid,
                    style: GoogleFonts.rubik(
                      height: 2,
                      textStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            /// IMPORTANT
                            loginStore.signOut(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                              padding: EdgeInsets.all(15)),
                          child: Text('Sign Out',
                              style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ))),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
