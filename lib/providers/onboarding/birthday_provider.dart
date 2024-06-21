import 'package:flutter/material.dart';

class BirthdayProvider extends ChangeNotifier {
  int age = 18;

  set updateAge(int x) {
    age = x;
    notifyListeners();
  }

  int get getAge => age;
}