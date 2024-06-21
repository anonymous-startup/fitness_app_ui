import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/screens/onboarding/components/weight_wheel.dart';

class TargetWeightScreen extends StatefulWidget {
  const TargetWeightScreen({super.key});

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  final List<bool> _toggleSelected = [false, true];
  late bool isKg = _toggleSelected[1];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Whats your target Body Weight?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Center(
            child: Image.asset(
              'assets/images/onboarding/target_weight.png',
              width: getProportionateScreenWidth(253),
              height: getProportionateScreenHeight(171),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          WeightWheel(isKg: isKg),
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
