import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class SelectionDropDown extends StatefulWidget {
  const SelectionDropDown({super.key, required this.title});
  final String title;
  @override
  State<SelectionDropDown> createState() => _SelectionDropDownState();
}

class _SelectionDropDownState extends State<SelectionDropDown> {
  @override
  ExpansionTileController controller = ExpansionTileController();

 
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      children: [
        
      ], 
      title: Row(children: [
        Image.asset(
          'assets/images/onboarding/muscle_pain.png',
          width: getProportionateScreenWidth(37),
        ),
        SizedBox(
          width: getProportionateScreenWidth(20),
        ),
        Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
      controller: controller,
    );
  }
}
