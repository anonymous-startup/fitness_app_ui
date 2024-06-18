import 'package:fitness_app/screens/onboarding/onboarding_screen.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
// import 'package:unbording/onbording.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: OnbordingScreen(),
    );
  }
}