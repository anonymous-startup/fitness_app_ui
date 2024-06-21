import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/components/plan_choice_button.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  int selectedIndex = -1;

  final List<dynamic> choices = [
    {"title": "Beginner", "description": "let’s start the journey"},
    {"title": "Intermediate", "description": "Take it to the next level"},
    {"title": "Advanced", "description": "Unleash your full potential"},
  ];

  void selectItem(int index) {
    setState(() {
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
            margin: EdgeInsets.only(top: getProportionateScreenHeight(50)),
            child: Center(
              child: Text(
                "Choose your plan",
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
              horizontal: getProportionateScreenWidth(40),
              vertical: getProportionateScreenHeight(26),
            ),
            height: getProportionateScreenHeight(400),
            child: ListView.builder(
              itemCount: choices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => selectItem(index),
                  child: PlanChoiceButton(
                    imagePath:
                        'assets/images/onboarding/choice_button_image.png',
                    color: selectedIndex == index ? primaryColor : Colors.black,
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
