import 'package:fitness_app/screens/onboarding/choose_birthday_screen.dart';
import 'package:fitness_app/screens/onboarding/choose_plan_screen.dart';
import 'package:fitness_app/screens/onboarding/height_screen.dart';
import 'package:fitness_app/screens/onboarding/injury_selection_screen.dart';
import 'package:fitness_app/screens/onboarding/location_screen.dart';
import 'package:fitness_app/screens/onboarding/models/onboarding_data_model.dart';
import 'package:fitness_app/screens/onboarding/notification_screen.dart';
import 'package:fitness_app/screens/onboarding/plank_input_screen.dart';
import 'package:fitness_app/screens/onboarding/pushups_choice_screen.dart';
import 'package:fitness_app/screens/onboarding/target_weight_screeen.dart';
import 'package:fitness_app/screens/onboarding/weight_screen.dart';

bool notifyTimeValidator() {
  return true;
}

bool planValidator() {
  return OnboardingDataModel.planChoice != -1;
}

bool pushupValidator() {
  return OnboardingDataModel.pushupChoice != -1;
}

bool plankValidator() {
  return OnboardingDataModel.planChoice != -1;
}

bool weightValidator() {
  return true;
}

bool targetWeightValidator() {
  return true;
}

bool heightValidator() {
  return true;
}

bool birthDateValidator() {
  return DateTime.now().year - OnboardingDataModel.birthYear > 5;
}

bool injuryValidator() {
  return true;
}

bool locaationValidator() {
  return true;
}

List<dynamic> contents = const [
  [NotificationScreen(), notifyTimeValidator],
  [ChoosePlanScreen(), planValidator],
  [PushupsChoiceScreen(), pushupValidator],
  [PlankInputScreen(), plankValidator],
  [WeightScreen(), weightValidator],
  [HeightScreen(), heightValidator],
  [TargetWeightScreen(), targetWeightValidator],
  [ChooseBirthdayScreen(), notifyTimeValidator],
  [InjurySelectionScreen(), notifyTimeValidator],
  [LocationScreen(), notifyTimeValidator],
];

