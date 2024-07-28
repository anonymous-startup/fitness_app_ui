import 'package:flutter/material.dart';
import '../../screens/nutrition/helper/meal.dart';
import '../../screens/nutrition/helper/macro.dart';

class DayMealIntakeProvider extends ChangeNotifier {
  Macro protein = Macro(macroName: "Protein");
  Macro fats = Macro(macroName: "Fats");
  Macro carbs = Macro(macroName: "Carbs");

  List<Meal> meals = [];

  void addMeal(Meal meal) {
    meals.add(meal);
    protein.macroQuantity += meal.protein;
    fats.macroQuantity += meal.fats;
    carbs.macroQuantity += meal.carbs;
    notifyListeners();
  }

  Meal getMeal(idx) => meals[idx];
}
