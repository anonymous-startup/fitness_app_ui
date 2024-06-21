import 'package:fitness_app/constants.dart';
import 'package:fitness_app/providers/onboarding/birthday_provider.dart';
import 'package:fitness_app/screens/onboarding/onboarding_screen.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BirthdayProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: 'Poppins',
        ),
        home: const OnbordingScreen(),
      ),
    );
  }
}
