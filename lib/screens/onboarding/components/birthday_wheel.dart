import 'package:fitness_app/providers/onboarding/birthday_provider.dart';
import 'package:fitness_app/screens/onboarding/components/birthday_tile.dart';
import 'package:fitness_app/screens/onboarding/models/onboarding_data_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BirthdayWheel extends StatefulWidget {
  const BirthdayWheel({
    super.key,
  });

  @override
  State<BirthdayWheel> createState() => _BirthdayWheelState();
}

class _BirthdayWheelState extends State<BirthdayWheel> {
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _yearController;
  late int _month;
  late int _day;
  late int _year;
  late int _daysInMonth;
  late List<int> years;

  final List<List<String>> monthDaysList = [
    ['Jan', '31'],
    ['Feb', '28'],
    ['Mar', '31'],
    ['Apr', '30'],
    ['May', '31'],
    ['Jun', '30'],
    ['Jul', '31'],
    ['Aug', '31'],
    ['Sep', '30'],
    ['Oct', '31'],
    ['Nov', '30'],
    ['Dec', '31']
  ];

  bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = now.month;
    _day = now.day;
    _year = 99; // by default

    years =
        List<int>.generate(100, (index) => DateTime.now().year - 99 + index);

    _daysInMonth = isLeapYear(years[_year])
        ? (_month == 1 ? 29 : int.parse(monthDaysList[_month][1]))
        : int.parse(monthDaysList[_month][1]);

    _monthController = FixedExtentScrollController(initialItem: _month);
    _monthController.addListener(() {
      setState(() {
        _month = _monthController.selectedItem % 12;
        _daysInMonth = isLeapYear(years[_year])
            ? (_month == 1 ? 29 : int.parse(monthDaysList[_month][1]))
            : int.parse(monthDaysList[_month][1]);
        OnboardingDataModel.birthMonth = _month;
        _dayController.jumpToItem(0);
      });
    });

    _dayController = FixedExtentScrollController(initialItem: _day);
    _dayController.addListener(() {
      setState(() {
        _day = _dayController.selectedItem % _daysInMonth;
        OnboardingDataModel.birthDay = _day;
      });
    });

    _yearController = FixedExtentScrollController(initialItem: _year);
    _yearController.addListener(() {
      setState(() {
        _year = _yearController.selectedItem % 100;
        OnboardingDataModel.birthYear = years[_year];
        _dayController.jumpToItem(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final birthdayProvider = Provider.of<BirthdayProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(110),
          height: getProportionateScreenHeight(200),
          child: ListWheelScrollView.useDelegate(
            controller: _monthController,
            itemExtent: 65,
            perspective: 0.0001,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List<BirthdayTile>.generate(
                12,
                (index) {
                  return BirthdayTile(
                    isSelected: _month == index,
                    value: monthDaysList[index][0],
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(110),
          height: getProportionateScreenHeight(200),
          child: ListWheelScrollView.useDelegate(
            controller: _dayController,
            itemExtent: 65,
            perspective: 0.0001,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List<BirthdayTile>.generate(
                _daysInMonth,
                (index) {
                  return BirthdayTile(
                    isSelected: _day == index,
                    value: index + 1,
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(110),
          height: getProportionateScreenHeight(200),
          child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (index) {
              birthdayProvider.updateAge = DateTime.now().year - years[index];
            },
            controller: _yearController,
            itemExtent: 65,
            perspective: 0.0001,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: years.length,
              builder: (context, index) {
                return BirthdayTile(
                  isSelected: years[_year] == years[index],
                  value: years[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
