import 'dart:ffi';

class Meal {
  String name;
  double calories;
  double protein;
  double carbs;
  double fats;

  Meal({
    this.name = "",
    this.calories = 0,
    this.carbs = 0,
    this.fats = 0,
    this.protein = 0,
  });
}
