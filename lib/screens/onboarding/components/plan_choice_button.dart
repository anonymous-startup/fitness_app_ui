import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class PlanChoiceButton extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  final String imagePath;

  const PlanChoiceButton({
    required this.color,
    required this.description,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: description.isEmpty ? getProportionateScreenHeight(17) : getProportionateScreenHeight(7),),
      decoration: BoxDecoration(
        color: color == primaryColor ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color,
          width: color == primaryColor ? 2.4 : 0.9,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(14)),
      child: Row(
        mainAxisAlignment: (imagePath.isNotEmpty)
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
        children: [
          //Image
          imagePath.isEmpty
              ? Container()
              : Image.asset(
                  imagePath,
                  width: getProportionateScreenWidth(54),
                ),

          //Title and description card
          Column(
            children: [
              //title
              Text(
                title,
                style: TextStyle(
                  color: color == primaryColor ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),

              //description
              description.isEmpty
                  ? Container()
                  : Text(
                      description,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: color == primaryColor
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
