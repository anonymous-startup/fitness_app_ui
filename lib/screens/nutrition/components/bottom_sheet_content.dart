import 'package:camera/camera.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/nutrition/camera_screen.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(50),
                  ),
                  child: const Text("Please select an option"),
                ),
                IconButton(
                  iconSize: getProportionateScreenHeight(20),
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(50)),
              child: ElevatedButton(
                onPressed: () {
                  // Handle option 1 button press
                },
                child: const Center(
                  child: Text(
                    'Add Maually',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: getProportionateScreenHeight(12),
            ),

            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(50)),
              child: ElevatedButton(
                onPressed: () async {
                  List<CameraDescription> cameras = await availableCameras();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(
                        cameras: cameras,
                      ),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Add Automcatically',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ), // Add some spacing between buttons
          ],
        ),
      ),
    );
  }
}
