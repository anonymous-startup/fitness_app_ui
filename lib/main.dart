import 'package:fitness_app/constants.dart';
import 'package:fitness_app/providers/nutrition/day_meal_intake_provider.dart';
import 'package:fitness_app/providers/onboarding/birthday_provider.dart';
import 'package:fitness_app/screens/nutrition/chat_with_gemini.dart';
import 'package:fitness_app/screens/nutrition/diet_input_screen.dart';

import 'package:fitness_app/screens/onboarding/onboarding_screen.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeen = prefs.getBool('hasSeen') ?? false;

  runApp(
    MyApp(hasSeen: hasSeen),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSeen;

  MyApp({required this.hasSeen});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BirthdayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DayMealIntakeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: 'Poppins',
        ),
        home: hasSeen ? const DietInputScreen() : const OnbordingScreen(),
        routes: {
          DietInputScreen.routeName: (ctx) => const DietInputScreen(),
          OnbordingScreen.routeName: (ctx) => const OnbordingScreen(),
          ChatWithGemini.routeName: (ctx) => const ChatWithGemini(),
        },
      ),
    );
  }
}
