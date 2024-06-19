import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/constants.dart';

class DialTile extends StatelessWidget {
  int weight;
  bool isSelected;
  bool isKg;

  DialTile({
    super.key,
    required this.weight,
    required this.isSelected,
    required this.isKg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        border: isSelected
            ? const Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                ),
              )
            : const Border.symmetric(),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weight >= 10 ? weight.toString() : '0$weight',
            style: TextStyle(
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold,
              color: isSelected ? primaryColor : Colors.grey,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                isKg ? 'kg' : 'lbs',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
