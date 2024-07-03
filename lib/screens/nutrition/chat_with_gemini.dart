import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/nutrition/components/dish_card.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class ChatWithGemini extends StatefulWidget {
  const ChatWithGemini({super.key});

  @override
  State<ChatWithGemini> createState() => _ChatWithGeminiState();
}

class _ChatWithGeminiState extends State<ChatWithGemini> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenHeight(50),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Akshay',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: getProportionateScreenHeight(50),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'How can i help you?',
              style: TextStyle(
                color: const Color(0xFF511CCC).withOpacity(0.4),
                fontSize: getProportionateScreenHeight(30),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(40),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(20),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF511CCC).withOpacity(0.15),
                borderRadius: BorderRadius.circular(
                  getProportionateScreenHeight(15),
                ),
              ),
              height: getProportionateScreenHeight(450),
              child: ListView(
                children: [
                  Text(
                    'Look Honey what i have prepare for you 😘',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(25),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  const Meal(
                    meadTime: 'Breakfast',
                    meal: 'Sunny Side Egg',
                  ),
                  const Meal(
                    meadTime: 'Lunch',
                    meal: 'Sunny Side Egg',
                  ),
                  const Meal(
                    meadTime: 'Dinner',
                    meal: 'Sunny Side Egg',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Anything you want to ask?',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: null,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Meal extends StatelessWidget {
  final String meadTime;
  final String meal;

  const Meal({
    required this.meadTime,
    required this.meal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$meadTime: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        DishCard(
          dishName: meal,
        ),
      ],
    );
  }
}
