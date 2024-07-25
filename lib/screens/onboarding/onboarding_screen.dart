import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/home/home_page.dart';
import 'package:fitness_app/screens/nutrition/diet_input_screen.dart';
import 'package:fitness_app/screens/onboarding/models/onboarding_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:unbording/content_model.dart';
// import 'package:unbording/home.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});
  static String routeName = "onboarding_screen";
  @override
  // ignore: library_private_types_in_public_api
  _OnbordingScreenState createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  int currentIndex = 0;
  late PageController _controller;
  late final SharedPreferences prefs;

  FToast ftoast = FToast();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: currentIndex == 0
            ? Container()
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (currentIndex != 0) {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.linear,
                    );
                  }
                },
              ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return contents[i][0];
              },
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(getProportionateScreenHeight(40)),
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                if (!contents[currentIndex][1]()) {
                  Fluttertoast.showToast(
                    msg: "provide input",
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: const Color.fromARGB(255, 33, 33, 33),
                    fontSize: 12.0,
                  );
                  return;
                }

                // ---------Last page logic------------
                if (currentIndex == contents.length - 1) {
                  prefs = await SharedPreferences.getInstance();
                  prefs.setBool('hasSeen', true);

                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DietInputScreen(),
                    ),
                  );
                }

                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                textStyle: const TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  currentIndex == contents.length - 1 ? "Continue" : "Next"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(
        right: getProportionateScreenWidth(5),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? primaryColor : Colors.grey,
      ),
    );
  }
}
