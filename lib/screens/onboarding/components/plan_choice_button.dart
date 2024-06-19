import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class PlanChoiceButton extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  final String imagePath;

  PlanChoiceButton({
    required this.color,
    required this.description,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenHeight(4)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color,
          width: color == primaryColor ? 2.4 : 1.5,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(14)),
      child: Row(
        children: [
          //Image
          Container(
            padding: EdgeInsets.all(getProportionateScreenHeight(7)),
            child: Image.asset(
              imagePath,
              scale: 4,
            ),
          ),

          //Title and description card
          Column(
            children: [
              //title
              Container(
                margin: EdgeInsets.only(left: getProportionateScreenHeight(18)),
                padding: EdgeInsets.all(getProportionateScreenHeight(1)),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenHeight(20)),
                ),
              ),

              //description
              Container(
                margin: EdgeInsets.only(left: getProportionateScreenHeight(24)),
                padding: EdgeInsets.all(getProportionateScreenHeight(1)),
                child: Text(description),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
