import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/nutrition/components/bottom_sheet_content.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class DietInputScreen extends StatelessWidget {
  const DietInputScreen({super.key});
  static String routeName = "diet_input_screen";

  void showBottomSheet(BuildContext context)  {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const BottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.only(
              left: getProportionateScreenWidth(12),
              right: getProportionateScreenWidth(12),
              bottom: getProportionateScreenHeight(17),
            ),
            padding: EdgeInsets.all(getProportionateScreenHeight(12)),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
             boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // shadow color
                  spreadRadius: 0, // spread radius
                  blurRadius: 10, // blur radius
                  offset: const Offset(0, 10), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () => showBottomSheet(context),
              child: Center(
                child: Text(
                  "Add Meal",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenHeight(16),
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

