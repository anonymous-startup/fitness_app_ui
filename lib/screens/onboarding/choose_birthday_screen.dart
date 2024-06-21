import 'package:fitness_app/constants.dart';
import 'package:fitness_app/providers/onboarding/birthday_provider.dart';
import 'package:fitness_app/screens/onboarding/components/birthday_wheel.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseBirthdayScreen extends StatefulWidget {
  const ChooseBirthdayScreen({super.key});

  @override
  State<ChooseBirthdayScreen> createState() => _ChooseBirthdayScreenState();
}

class _ChooseBirthdayScreenState extends State<ChooseBirthdayScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'When is your Birthday?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset(
                'assets/images/onboarding/birthday_cake.png',
                width: getProportionateScreenWidth(340),
              ),
              Consumer<BirthdayProvider>(
                builder: (context, user, _) => Text(
                  user.getAge.toString(),
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(35),
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const BirthdayWheel(),
        ],
      ),
    );
  }
}
