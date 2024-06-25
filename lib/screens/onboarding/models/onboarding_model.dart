import 'package:fitness_app/screens/onboarding/choose_birthday_screen.dart';
import 'package:fitness_app/screens/onboarding/choose_plan_screen.dart';
import 'package:fitness_app/screens/onboarding/height_screen.dart';
// import 'package:fitness_app/screens/onboarding/height_screen.dart';
import 'package:fitness_app/screens/onboarding/injury_selection_screen.dart';
import 'package:fitness_app/screens/onboarding/notification_screen.dart';
import 'package:fitness_app/screens/onboarding/plank_input_screen.dart';
import 'package:fitness_app/screens/onboarding/pushups_choice_screen.dart';
import 'package:fitness_app/screens/onboarding/target_weight_screeen.dart';
import 'package:fitness_app/screens/onboarding/weight_screen.dart';

List<dynamic> contents = const [
    // HeightCalculator(),
    HeightScreen(),
    InjurySelectionScreen(),
    ChooseBirthdayScreen(),
    NotificationScreen(),
    ChoosePlanScreen(),
    PushupsChoiceScreen(),
    PlankInputScreen(),
    WeightScreen(),
    TargetWeightScreen(),
];
