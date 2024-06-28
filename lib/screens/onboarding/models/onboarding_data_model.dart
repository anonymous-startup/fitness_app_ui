import 'package:flutter/material.dart';

class OnboardingDataModel {
  static int currentWeight = 0;
  static int targetWeight = 0;

  static int birthYear = 0;
  static int birthMonth = 0;
  static int birthDay = 0;

  static int planChoice = -1;
  static int plankChoice = -1;
  static int pushupChoice = -1;

  static bool isCm = true; // Assuming default is centimeters
  static bool isCurrKg = true; // Assuming default is kilograms
  static bool isTargetKg = true;

  static TimeOfDay reminderTime = const TimeOfDay(hour: 0, minute: 0);

  static double latitude = 0.0;
  static double longitude = 0.0;
  static double height = 0;

  static List<String> injuries = [];
}
