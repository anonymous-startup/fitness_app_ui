import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/components/plan_choice_button.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class PlankInputScreen extends StatefulWidget {
  const PlankInputScreen({super.key});

  @override
  State<PlankInputScreen> createState() => _PlankInputScreenState();
}

class _PlankInputScreenState extends State<PlankInputScreen> {
  int selectedIndex = -1;

  final List<dynamic> choices = [
    {"title": "Beginner", "description": "less than a minute"},
    {"title": "Intermediate", "description": "less than 2 minutes"},
    {"title": "Advanced", "description": "more than 2 minutes"},
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
            margin: EdgeInsets.only(
              top: getProportionateScreenHeight(26),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(30),
            ),
            child: Center(
              child: Text(
                softWrap: true,
                "How long can you hold plank ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          //Image
          Container(
            margin: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: getProportionateScreenHeight(10),
            ),
            child: Image.asset('assets/images/onboarding/plank_image.png',width: getProportionateScreenWidth(250),),
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
