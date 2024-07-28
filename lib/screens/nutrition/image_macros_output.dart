import 'dart:io';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/providers/nutrition/day_meal_intake_provider.dart';
import 'package:fitness_app/screens/nutrition/components/macro_card.dart';
import 'package:fitness_app/screens/nutrition/components/meal_not_found.dart';
import 'package:fitness_app/screens/nutrition/diet_input_screen.dart';
import 'package:fitness_app/screens/nutrition/helper/meal.dart';
import 'package:fitness_app/screens/nutrition/components/shimmer_container.dart';
import 'package:fitness_app/screens/nutrition/models/gemini_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:fitness_app/utility/string_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageMacrosOutput extends StatefulWidget {
  const ImageMacrosOutput({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<ImageMacrosOutput> createState() => _ImageMacrosOutputState();
}

class _ImageMacrosOutputState extends State<ImageMacrosOutput> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> callGemini() async {
    Map<String, dynamic> res = {};
    res = await Gemini.getMacrosFromImage(imagePrompt1, widget.imageFile);

    // testing lottie widget
    // res = {
    //   "name": 'not found',
    // };

    // testing gemini output widget
    // res = {
    //   "name": 'Masala Dosa abldab ',
    //   "calories": '221cal',
    //   "protein": '8g',
    //   "fat": '43g',
    //   "carbs": '1.3g',
    // };

    return res;
  }

  Meal meal = Meal();

  void addMeal() {
    if (meal.name.isNotEmpty) {
      Provider.of<DayMealIntakeProvider>(context, listen: false).addMeal(meal);
    }

    int count = 0;
  Navigator.popUntil(context, (route) {
    return count++ == 3; // Change 2 to the number of screens you want to pop
  });
  }

  final width = SizeConfig.screenWidth;
  final height = SizeConfig.screenHeight;
  Map<dynamic, dynamic> geminiMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(40),
              ),

              // Image taken
              Container(
                margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
                child: Center(
                  child: ClipOval(
                    child: Image(
                      fit: BoxFit.cover,
                      height: getProportionateScreenHeight(250),
                      width: getProportionateScreenWidth(250),
                      image: FileImage(widget.imageFile),
                    ),
                  ),
                ),
              ),

              // Name and macros
              FutureBuilder(
                future: callGemini(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    geminiMap = snapshot.data!;
                    List macros =
                        geminiMap.keys.where((key) => key != 'name').toList();

                    meal.name = capitalizeEachWord(
                      geminiMap.containsKey('name')
                          ? (geminiMap["name"] == "not found"
                              ? ""
                              : geminiMap['name'])
                          : "",
                    );

                    bool isMealInValid = meal.name.isEmpty;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: getProportionateScreenHeight(14)),
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: RichText(
                            overflow: isMealInValid
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: isMealInValid ? "Oops! " : 'Meal ',
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: isMealInValid
                                        ? getProportionateScreenHeight(28)
                                        : getProportionateScreenHeight(30),
                                  ),
                                ),
                                TextSpan(
                                  text: isMealInValid
                                      ? "This is not a food item 🤔"
                                      : meal.name,
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: getProportionateScreenHeight(28),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        macros.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: getProportionateScreenHeight(20)),
                                child: Text(
                                  "Macros are",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF511CCC)
                                        .withOpacity(0.4),
                                    fontSize: getProportionateScreenHeight(25),
                                  ),
                                ),
                              )
                            : Container(),

                        //macrosss
                        macros.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 94, 36, 227)
                                      .withOpacity(0.14),
                                ),
                                margin: EdgeInsets.only(
                                  top: getProportionateScreenHeight(10),
                                  left: getProportionateScreenWidth(18),
                                  right: getProportionateScreenWidth(18),
                                ),
                                height: getProportionateScreenHeight(310),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: getProportionateScreenHeight(70),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: getProportionateScreenHeight(
                                                  16),
                                              left: getProportionateScreenWidth(
                                                  7),
                                            ),
                                            height:
                                                getProportionateScreenHeight(
                                                    60),
                                            child: Image.asset(
                                              "assets/images/nutrition/ai.png",
                                              width:
                                                  getProportionateScreenWidth(
                                                50,
                                              ),
                                              height:
                                                  getProportionateScreenHeight(
                                                50,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: getProportionateScreenHeight(
                                                22,
                                              ),
                                              left: getProportionateScreenWidth(
                                                10,
                                              ),
                                            ),
                                            child: Text(
                                              "Fobot says......",
                                              style: TextStyle(
                                                fontFamily: "poppins",
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        22),
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(240),
                                      child: GridView.builder(
                                        itemCount: macros.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          // crossAxisSpacing: getProportionateScreenWidth(10),
                                          mainAxisSpacing:
                                              getProportionateScreenHeight(15),
                                          childAspectRatio:
                                              getProportionateScreenWidth(80) /
                                                  getProportionateScreenHeight(
                                                      40),
                                        ),
                                        itemBuilder: (context, index) {
                                          String macro = macros[index];

                                          if (macro == "protein") {
                                            meal.protein = double.parse(
                                              extractNumberFromString(
                                                geminiMap[macro],
                                              ),
                                            );
                                          } else if (macro == "carbs") {
                                            meal.carbs = double.parse(
                                              extractNumberFromString(
                                                geminiMap[macro],
                                              ),
                                            );
                                          } else if (macro == "calories") {
                                            meal.calories = double.parse(
                                              extractNumberFromString(
                                                geminiMap[macro],
                                              ),
                                            );
                                          } else if (macro == "fat") {
                                            meal.fats = double.parse(
                                              extractNumberFromString(
                                                geminiMap[macro],
                                              ),
                                            );
                                          }

                                          return MacroCard(
                                            macroName:
                                                capitalizeEachWord(macro),
                                            macroQuantity:
                                                geminiMap[macro].toString(),
                                            leftMargin: (index % 2 == 0)
                                                ? getProportionateScreenWidth(
                                                    14)
                                                : getProportionateScreenWidth(
                                                    7),
                                            rightMargin: (index % 2 == 0)
                                                ? getProportionateScreenWidth(7)
                                                : getProportionateScreenWidth(
                                                    14),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : MealNotFound(),
                        // Expanded(child: Container()),
                        Container(
                          margin: EdgeInsets.only(
                            left: getProportionateScreenWidth(14),
                            top: getProportionateScreenHeight(28),
                            right: getProportionateScreenWidth(14),
                            bottom: getProportionateScreenHeight(17),
                          ),
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(10)),
                          decoration: BoxDecoration(
                            color: (!geminiMap.containsKey('name') ||
                                    geminiMap["name"] == "not found")
                                ? Colors.grey
                                : primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.2), // shadow color
                                spreadRadius: 0, // spread radius
                                blurRadius: 10, // blur radius
                                offset: const Offset(
                                    0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: addMeal,
                            child: Center(
                              child: Text(
                                isMealInValid ? "Go Back" : "Add",
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenHeight(16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return const LoadingContainer();
                },
              ),
            ],
          ),
          Positioned(
            top: getProportionateScreenHeight(30),
            left: getProportionateScreenWidth(10),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          child: Center(
            child: ShimmerContainer(
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(180),
            ),
          ),
        ),

        // Macros
        Container(
          margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          child: Center(
            child: ShimmerContainer(
              height: getProportionateScreenHeight(320),
              width: getProportionateScreenWidth(340),
            ),
          ),
        ),
      ],
    );
  }
}
