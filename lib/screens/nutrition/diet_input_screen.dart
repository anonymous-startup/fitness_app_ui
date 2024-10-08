import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/nutrition/chat_with_gemini.dart';
import 'package:fitness_app/screens/nutrition/components/bottom_sheet_content.dart';
import 'package:fitness_app/screens/nutrition/helper/macro.dart';
import 'package:fitness_app/screens/nutrition/helper/meal.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../providers/nutrition/day_meal_intake_provider.dart';

class DietInputScreen extends StatelessWidget {
  const DietInputScreen({super.key});
  static String routeName = "diet_input_screen";

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const BottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Macro> todayMacroValues = [
      Provider.of<DayMealIntakeProvider>(context, listen: false).carbs,
      Provider.of<DayMealIntakeProvider>(context, listen: false).protein,
      Provider.of<DayMealIntakeProvider>(context, listen: false).fats,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>Navigator.pushNamed(context,ChatWithGemini.routeName),child:   const Image(image: NetworkImage("https://www.thespruceeats.com/thmb/oIaxLSj0xxAbD39jykKk3XsFo9s=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/SES-chicken-biryani-recipe-7367850-hero-A-ed211926bb0e4ca1be510695c15ce111.jpg")),),
      body: Container(
        margin: EdgeInsets.all(
          getProportionateScreenWidth(15),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nutrition",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(23),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "History >",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(

                    height: getProportionateScreenHeight(340),
                    decoration: BoxDecoration(

                      color: secondaryLightColor,
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(15),
                      ),
                    ),
                    child: SfCircularChart(
                      legend: Legend(
                        position: LegendPosition.bottom,
                        isVisible: true,
                        iconHeight: getProportionateScreenHeight(30),
                      ),
                      // annotations: const <CircularChartAnnotation>[
                      //   CircularChartAnnotation(
                      //     widget: Text(
                            
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         color: primaryColor,
                      //       ),
                      //     ),
                      //   ),
                      // ],
                      series: [
                        DoughnutSeries<Macro, String>(
                          dataSource: todayMacroValues,
                          xValueMapper: (Macro data, _) => data.name,
                          yValueMapper: (Macro data, _) => data.quantity,
                          dataLabelSettings: const DataLabelSettings(),
                          innerRadius: '60%',
                          explode: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
              height: getProportionateScreenHeight(200),
              child: ListView.builder(
                itemCount:
                    Provider.of<DayMealIntakeProvider>(context, listen: false)
                        .meals
                        .length,
                itemBuilder: (context, index) {
                  Meal meal =
                      Provider.of<DayMealIntakeProvider>(context, listen: false)
                          .getMeal(index);
                  return InkWell(
                    onTap: () {},
                    child: Container(
            
                      margin: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(20 )),
                      decoration: BoxDecoration(
                        color: secondaryLightColor,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(30),
                        ),
                      ),
                      height: getProportionateScreenHeight(55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            meal.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: getProportionateScreenHeight(16),
                            ),
                          ),
                         
                          Text(
                            "${meal.calories.toString()} cal",
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: getProportionateScreenHeight(17)
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              // margin: EdgeInsets.only(
              //   left: getProportionateScreenWidth(12),
              //   right: getProportionateScreenWidth(12),
              //   bottom: getProportionateScreenHeight(17),
              // ),
              padding: EdgeInsets.all(getProportionateScreenHeight(12)),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // shadow color
                    spreadRadius: 0, // spread radius
                    blurRadius: 10, // blur radius
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              child: InkWell(
                onTap: () => showBottomSheet(context),
                child: Center(
                  child: Text("Add Meal",
                      style: TextStyle(
                        color: primaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(16),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Macro {
//   String? macroName;
//   int? macroQuantity;
//   Macro({this.macroName, this.macroQuantity});

//   set quantity(int val) {
//     macroQuantity = val;
//   }

//   set name(String val) {
//     macroName = val;
//   }

//   String get name => macroName as String;
//   int get quantity => macroQuantity as int;
// }
