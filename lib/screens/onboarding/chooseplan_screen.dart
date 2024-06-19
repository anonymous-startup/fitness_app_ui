import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Title
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(130)),
            child: Center(
              child: Text(
                "Choose your plan",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          //selection buttons


        ],
      ),
    );
  }
}
