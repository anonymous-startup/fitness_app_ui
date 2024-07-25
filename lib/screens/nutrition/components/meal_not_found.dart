import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MealNotFound extends StatefulWidget {
  @override
  _MealNotFoundState createState() => _MealNotFoundState();
}

class _MealNotFoundState extends State<MealNotFound> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(350),
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/lottie/meal_not_found.json',
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..repeat(); // Loop the animation
        },
      ),
    );
  }
}
