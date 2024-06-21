import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class BirthdayTile extends StatelessWidget {
  final bool isSelected;
  final dynamic value;

  const BirthdayTile({
    super.key,
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:
            isSelected ? BorderRadius.circular(10) : BorderRadius.zero,
        border: isSelected
            ? Border.all(
                color: Colors.grey,
                width: 2.4,
              )
            : const Border.symmetric(),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        value is String
            ? value
            : value >= 10
                ? value.toString()
                : '0$value',
        style: TextStyle(
          fontSize: isSelected
              ? getProportionateScreenHeight(25)
              : getProportionateScreenHeight(20),
          fontWeight: FontWeight.bold,
          color: isSelected ? primaryColor : Colors.grey,
        ),
      ),
    );
  }
}
