import 'dart:io';
import 'package:fitness_app/screens/nutrition/helper/string_parser.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class Gemini {
  static var apiKey = "AIzaSyBLsmNEjXNK7s5xkQyp04-TXX3uadAmzgI";
 

  static Future<Map<String,dynamic>> getMacrosFromImage(String prompt, File imageFile) async {
    print("started------------------------------------");
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: Gemini.apiKey);
    final image =  await (imageFile.readAsBytes());

    final imageParts = [ DataPart('image/jpeg', image) ];
    final promptParts = TextPart(prompt);

    final content = Content.multi([promptParts, ...imageParts]);
    final response = await model.generateContent([content]);
    print("---------------------Response----------------------------");
    print(response.text);
    print("------------------------------------------------------");


    Map<String,dynamic> result = convertStringToMap(response.text!);
    return result;
  }
}