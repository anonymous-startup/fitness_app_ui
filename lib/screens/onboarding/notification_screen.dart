import 'package:fitness_app/screens/onboarding/components/plan_choice_button.dart';
import 'package:fitness_app/screens/onboarding/components/reminder_wheel.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Whats your target Body Weight?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(26),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          padding: EdgeInsets.all(
            getProportionateScreenHeight(10),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/onboarding/alarm_clock.png',
                scale: 2,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(getProportionateScreenHeight(10)),
                  child: const Text(
                    'Smart reminder helped 75% users achieve thier goal faster',
                    softWrap: true,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        const ReminderWheel(),
      ],
    );
  }
}
