import 'package:fitness_app/screens/onboarding/components/weight_tile.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class WeightWheel extends StatefulWidget {
  final bool isKg;

  const WeightWheel({
    super.key,
    required this.isKg,
  });

  @override
  State<WeightWheel> createState() => _WeightWheelState();
}

class _WeightWheelState extends State<WeightWheel> {
  late FixedExtentScrollController _controller;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.isKg ? 50 : 150;
    _controller = FixedExtentScrollController(initialItem: _selectedIndex);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.selectedItem;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(100),
      height: getProportionateScreenHeight(200),
      child: Center(
        child: ListWheelScrollView.useDelegate(
          controller: _controller,
          itemExtent: 65,
          perspective: 0.0001,
          diameterRatio: 1.2,
          physics: const FixedExtentScrollPhysics(),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: widget.isKg ? 150 : 200,
            builder: (context, index) {
              return WeightTile(
                isSelected: _selectedIndex == index,
                quantity: index,
                isDefault: widget.isKg,
                unitOne: "kg",
                unitTwo: "lbs",
              );
            },
          ),
        ),
      ),
    );
  }
}
