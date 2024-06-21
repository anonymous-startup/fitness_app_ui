import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class ReminderTile extends StatelessWidget {
  final bool isSelected;
  final int value;

  const ReminderTile({
    super.key,
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        value >= 10 ? value.toString() : '0$value',
        style: TextStyle(
          fontSize: isSelected
              ? getProportionateScreenHeight(25)
              : getProportionateScreenHeight(20),
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
