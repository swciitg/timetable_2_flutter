import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timetable_2_demo/stores/login_store.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginStore = Provider.of<LoginStore>(context);
    return Drawer(
      child: ElevatedButton(
        onPressed: () {
          /// IMPORTANT
          loginStore.signOut(context);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent, padding: EdgeInsets.all(15)),
        child: Text('Sign Out',
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ))),
      ),
    );
  }
}
