import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/components/plan_choice_button.dart';
import 'package:fitness_app/screens/onboarding/components/selection_drop_down.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class InjurySelectionScreen extends StatefulWidget {
  const InjurySelectionScreen({super.key});

  @override
  State<InjurySelectionScreen> createState() => _InjurySelectionScreenState();
}

class _InjurySelectionScreenState extends State<InjurySelectionScreen> {
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
              left: getProportionateScreenWidth(3),
              right: getProportionateScreenWidth(3),
            ),
            child: Center(
              child: Text(
                softWrap: true,
                "Any physical Issues?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: secondaryTextColor,
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
                  child: SelectionDropDown(title: "Muscle Pain",),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}