import 'dart:io';

import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/nutrition/components/shimmer_container.dart';
import 'package:fitness_app/screens/nutrition/models/gemini_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class ImageMacrosOutput extends StatefulWidget {
  const ImageMacrosOutput({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<ImageMacrosOutput> createState() => _ImageMacrosOutputState();
}

class _ImageMacrosOutputState extends State<ImageMacrosOutput> {
  bool isLoading = true;
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 3), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    super.initState();
  }

  Future<Map<String, dynamic>> callGemini() async {
    Map<String, dynamic> res =
        await Gemini.getMacrosFromImage(imagePrompt1, widget.imageFile);
    print(res);
    print("insideeeeeeeeee");
    return res;
  }

  final width = SizeConfig.screenWidth;
  final height = SizeConfig.screenHeight;
  Map<dynamic, dynamic> geminiMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Image taken
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
            child: Center(
              child: ClipOval(
                child: Image(
                  fit: BoxFit.cover,
                  height: getProportionateScreenHeight(220),
                  width: getProportionateScreenWidth(220),
                  image: FileImage(widget.imageFile),
                ),
              ),
            ),
          ),

          //name

          FutureBuilder(
            future: callGemini(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                geminiMap = snapshot.data!;
                List macros =
                    geminiMap.keys.where((key) => key != 'name').toList();
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: getProportionateScreenHeight(10)),
                      child: Text(
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(24),
                          fontWeight: FontWeight.bold,
                        ),
                        geminiMap.containsKey('name')
                            ? geminiMap['name']
                            : "Not found",
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey,
                            width: getProportionateScreenWidth(2),
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(
                        top: getProportionateScreenHeight(10),
                      ),
                      height: getProportionateScreenHeight(300),
                      child: ListView.builder(
                        itemCount: macros.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: getProportionateScreenHeight(10),
                              ),
                              child: Text(
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 102, 93, 93),
                                    fontSize: getProportionateScreenHeight(22),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  "${macros[index]} : ${geminiMap[macros[index]].toString()}"),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return const LoadingContainer();
            },
          ),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.only(
              left: getProportionateScreenWidth(12),
              right: getProportionateScreenWidth(12),
              bottom: getProportionateScreenHeight(17),
            ),
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
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
              onTap: () async {
                // await Gemini.getMacrosFromImage(imagePrompt1, widget.imageFile);
              },
              child: Center(
                child: Text(
                  "Add",
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

        //macros
        Container(
          margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10)),
                child: Center(
                  child: ShimmerContainer(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(300),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10)),
                child: Center(
                  child: ShimmerContainer(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(300),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10)),
                child: Center(
                  child: ShimmerContainer(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
