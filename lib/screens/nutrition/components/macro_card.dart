import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class MacroCard extends StatelessWidget {
  const MacroCard(
      {super.key, required this.macroName, required this.macroQuantity});
  final String macroName;
  final String macroQuantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getProportionateScreenHeight(100),
      decoration: BoxDecoration(
        color: Colors.white, // Background color of grid item
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
       margin: EdgeInsets.only(bottom: getProportionateScreenHeight(13),right: getProportionateScreenWidth(8),left: getProportionateScreenWidth(8),),
      padding: EdgeInsets.all(getProportionateScreenHeight(6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            macroName,
            style: TextStyle(
              fontFamily: 'PTMono',
              color: Colors.black,
              fontSize: getProportionateScreenHeight(17),
              fontWeight: FontWeight.w500,
            ),
             softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
          // Spacing between title and value
          Text(
            macroQuantity,
            style: TextStyle(
              fontFamily: "poppins",
              color: primaryColor,
              fontSize: getProportionateScreenHeight(22),
              fontWeight: FontWeight.bold,
            ),
             softWrap: true,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
