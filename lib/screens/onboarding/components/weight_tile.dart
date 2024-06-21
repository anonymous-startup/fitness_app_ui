import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/constants.dart';

class WeightTile extends StatelessWidget {
  final int quantity;
  final bool isSelected;
  final bool isDefault;
  final String unitOne;
  final String unitTwo;

  const WeightTile({
    super.key,
    required this.unitOne,
    required this.unitTwo,
    required this.quantity,
    required this.isSelected,
    required this.isDefault,
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
            quantity >= 10 ? quantity.toString() : '0$quantity',
            style: TextStyle(
              fontSize: isSelected
                  ? getProportionateScreenHeight(25)
                  : getProportionateScreenHeight(20),
              fontWeight: FontWeight.bold,
              color: isSelected ? primaryColor : Colors.grey,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                isDefault ? unitOne : unitTwo,
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
