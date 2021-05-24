import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Providers/classes.dart';
import './screens/timetable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Classes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Timetable",
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
          indicatorColor: Color.fromRGBO(77, 92, 98, 1),
          accentColor: Colors.amber,
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
        ),
        home: Timetable(),
      ),
    );
  }
}
