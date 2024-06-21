import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/components/reminder_tile.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class ReminderWheel extends StatefulWidget {
  const ReminderWheel({
    super.key,
  });

  @override
  State<ReminderWheel> createState() => _ReminderWheelState();
}

class _ReminderWheelState extends State<ReminderWheel> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late int _hour;
  late int _minute;

  @override
  void initState() {
    super.initState();
    _hour = 20;
    _minute = 10;
    _hourController = FixedExtentScrollController(initialItem: _hour);
    _hourController.addListener(() {
      setState(() {
        _hour = _hourController.selectedItem % 24;
      });
    });

    _minuteController = FixedExtentScrollController(initialItem: _minute);
    _minuteController.addListener(() {
      setState(() {
        _minute = _minuteController.selectedItem % 60;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: primaryColor,
          ),
          width: 200,
          height: 60,
        ),
        const Text(
          ':',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(200),
              child: ListWheelScrollView.useDelegate(
                  controller: _hourController,
                  itemExtent: 65,
                  perspective: 0.0001,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<ReminderTile>.generate(
                      24,
                      (index) {
                        return ReminderTile(
                          isSelected: _hour == index,
                          value: index,
                        );
                      },
                    ),
                  )
                  // childDelegate: ListWheelChildBuilderDelegate(
                  //   childCount: 25,
                  //   builder: (context, index) {
                  //     return ReminderTile(
                  //       isSelected: _hour == index,
                  //       value: index,
                  //     );
                  //   },
                  // ),
                  ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(200),
              child: ListWheelScrollView.useDelegate(
                  controller: _minuteController,
                  itemExtent: 65,
                  perspective: 0.0001,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<ReminderTile>.generate(
                      60,
                      (index) {
                        return ReminderTile(
                          isSelected: _minute == index,
                          value: index,
                        );
                      },
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
