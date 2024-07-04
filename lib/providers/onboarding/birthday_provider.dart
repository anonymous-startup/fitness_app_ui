import 'package:flutter/material.dart';

class BirthdayProvider extends ChangeNotifier {
  int age = 0;

  set updateAge(int x) {
    age = x;
    notifyListeners();
  }

  int get getAge => age;
}