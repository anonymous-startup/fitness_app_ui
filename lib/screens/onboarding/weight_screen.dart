import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/screens/onboarding/components/weight_wheel.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final List<bool> _toggleSelected = [false, true];
  late bool isKg = _toggleSelected[1];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Whats your Body Weight?',
              style: TextStyle(
                fontSize: getProportionateScreenHeight(25),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Center(
            child: Image.asset(
              'assets/images/onboarding/weight.png',
              width: getProportionateScreenWidth(253),
              height: getProportionateScreenHeight(171),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          WeightWheel(isKg: isKg,),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          ToggleButtons(
            borderWidth: 2,
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            constraints: const BoxConstraints(
              minWidth: 50,
              minHeight: 30,
            ),
            isSelected: _toggleSelected,
            onPressed: (index) {
              setState(() {
                _toggleSelected[0] = false;
                _toggleSelected[1] = false;
                _toggleSelected[index] = true;
                isKg = index == 0 ? false : true;
              });
            },
            fillColor: primaryColor,
            children: [
              Text(
                'LB',
                style: TextStyle(
                  color: _toggleSelected[0] ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'KG',
                style: TextStyle(
                  color: _toggleSelected[1] ? Colors.white : Colors.black,
                ),
              ),
            ],
          )
       
        ],
      ),
    );
  }
}
