import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utilities/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.yellow,
          accentColor: Colors.black,
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      home: Location(),
    );
  }
}
