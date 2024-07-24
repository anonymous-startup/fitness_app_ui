import 'package:flutter/material.dart';

const primaryColor = Color(0xff511ccc);
const primaryTextColor = Color.fromARGB(255, 255, 255, 255);
const secondaryTextColor = Color.fromARGB(255, 0, 0, 0);
const tertiaryTextColor = Color(0xffEBFF00);
var primaryLightColor = Color(0xFF511CCC).withOpacity(0.9);
var secondaryLightColor = Color(0xFF511CCC).withOpacity(0.1);

String imagePrompt1 = """
  Detect the item in the provided image and for the detected item provide the following in map format {key } and nothing else. The keys should include name, calories, protein, fat, and carbs. THE FIRST LINE OF OUTPUT SHOULD ALWAYS CONTAIN THE REQUIRED MAP. If it is not a food item, then say 'not a food item'. If the detected item is not food, then the map should look like:{ name: 'not found' } If it is food, then the map should look like: { name: detected item name, calories: detected item calories and its mesuring unit, protein: detected item protein and its mesuring unit, carbs: detected item carbs and its mesuring unit, fat: detected item fat and its mesuring unit, } The values for calories, protein, carbs, and fat should be numerical values in grams (e.g., 221cal, 8g, 43g, 1.3g). The output should not contain anything except the map and THE FIRST LINE OF OUTPUT SHOULD ALWAYS CONTAIN THE REQUIRED MAP.
""";

String imagePrompt2 = """
  convert this map into a map where all keys except name has number as its respective value. provide the map in its original format only after making the changes that is in text fomat for e.g { name: "paneer tikka masala", calories: 510cal , protein: 21g, carbs: 61g , fat: 20g } provide nothing other than the expected map. The first line of output should contain the required map only. Don't say sure or anything.
""";
