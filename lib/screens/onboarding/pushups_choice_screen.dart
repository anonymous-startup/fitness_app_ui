import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/components/plan_choice_button.dart';
import 'package:fitness_app/screens/onboarding/models/onboarding_data_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class PushupsChoiceScreen extends StatefulWidget {
  const PushupsChoiceScreen({super.key});

  @override
  State<PushupsChoiceScreen> createState() => _PushupsChoiceScreenState();
}

class _PushupsChoiceScreenState extends State<PushupsChoiceScreen> {
  int selectedIndex = -1;

  final List<dynamic> choices = [
    {"title": "I can't do it 😔", "description": ""},
    {"title": "0-5 repeats", "description": ""},
    {"title": "5-10 repeats", "description": ""},
  ];

  void selectItem(int index) {
    setState(() {
      OnboardingDataModel.pushupChoice = index;
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Title
          Container(
            margin: EdgeInsets.only(
              top: getProportionateScreenHeight(50),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(30),
            ),
            child: Center(
              child: Text(
                softWrap: true,
                textAlign: TextAlign.center,
                "How many pushups can you do?",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          //selection buttons
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(27),
                vertical: getProportionateScreenHeight(26)),
            height: getProportionateScreenHeight(400),
            child: ListView.builder(
              itemCount: choices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => selectItem(index),
                  child: PlanChoiceButton(
                    imagePath: '',
                    color: selectedIndex == index ? primaryColor : Colors.grey,
                    title: choices[index]['title'],
                    description: choices[index]['description'],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
