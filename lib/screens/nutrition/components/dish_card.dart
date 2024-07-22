import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class DishCard extends StatelessWidget {
  final String dishName;

  const DishCard({
    required this.dishName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(15),
        ),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(20),
      ),
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(10),
        horizontal: getProportionateScreenHeight(10),
      ),
      height: getProportionateScreenHeight(180),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: getProportionateScreenHeight(50),
                backgroundImage: const NetworkImage(
                  'https://img.freepik.com/premium-photo/sexy-ass-lingerie-female-buttocks-slim-figure-bikini-thong_265223-99236.jpg?w=1800',
                ),
              ),
              Text(dishName),
            ],
          ),
          SizedBox(
            width: getProportionateScreenHeight(10),
          ),
          const VerticalDivider(),
          Column(
            children: [
              Container(
                width: getProportionateScreenHeight(100),
                margin: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                ),
                child: const Text(
                  'Calories : 100',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Macro(macroName: 'Protein', grams: 9),
              const Macro(macroName: 'Carbs', grams: 9),
              const Macro(macroName: 'Fats', grams: 9),
            ],
          ),
        ],
      ),
    );
  }
}

class Macro extends StatelessWidget {
  final String macroName;
  final int grams;

  const Macro({
    required this.macroName,
    required this.grams,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenHeight(100),
      margin: EdgeInsets.only(
        top: getProportionateScreenHeight(10),
        left: getProportionateScreenWidth(25),
      ),
      child: Text(
        '$macroName : ${grams}g',
      ),
    );
  }
}
