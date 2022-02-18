import 'package:covid_tracker/Design/HomeScreen.dart';
import 'package:covid_tracker/News/news.dart';
import 'package:covid_tracker/News/view_news.dart';
import 'package:covid_tracker/Screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily,
        primarySwatch: Colors.blue,
        // brightness: Brightness.dark,
      ),
      home: SplashScreen(),
    );
  }
}
