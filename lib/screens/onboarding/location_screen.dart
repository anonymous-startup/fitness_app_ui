import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/components/plan_choice_button.dart';
import 'package:fitness_app/screens/onboarding/models/onboarding_data_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int selectedIndex = -1;
  Position? _position;

  final List<dynamic> choices = [
    {"title": "Yours Device Location", "description": ""},
    {"title": "Ask me Later", "description": ""},
  ];

  void selectItem(int index) async {
    setState(() {
      selectedIndex = index;
    });

    if (selectedIndex == 0) {
      _position = await _determinePosition();
      OnboardingDataModel.latitude = _position!.latitude;
      OnboardingDataModel.longitude = _position!.longitude;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Title
          Container(
            margin: EdgeInsets.only(
              top: getProportionateScreenHeight(26),
              left: getProportionateScreenWidth(30),
              right: getProportionateScreenWidth(30),
            ),
            child: Center(
              child: Text(
                softWrap: true,
                "Your Location?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          //Image
          Container(
            margin: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: getProportionateScreenHeight(10),
            ),
            child: Image.asset(
              'assets/images/onboarding/location.png',
              width: getProportionateScreenWidth(250),
            ),
          ),

          //selection buttons
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(27),
              vertical: getProportionateScreenHeight(26),
            ),
            height: getProportionateScreenHeight(400),
            child: ListView.builder(
              itemCount: choices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => selectItem(index),
                  child: PlanChoiceButton(
                    imagePath: '',
                    color: selectedIndex == index ? primaryColor : Colors.grey,
                    title: choices[index]['title'],
                    description: choices[index]['description'],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
