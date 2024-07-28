import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/nutrition/components/dish_card.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatWithGemini extends StatefulWidget {
  static String routeName = "chat_with_gemini_screen";
  const ChatWithGemini({super.key});

  @override
  State<ChatWithGemini> createState() => _ChatWithGeminiState();
}

class _ChatWithGeminiState extends State<ChatWithGemini> {
  ChatUser currentUser = ChatUser(id: "0", firstName: "Akshay");
  ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "Yours 😘",
      profileImage:
          "https://c8.alamy.com/comp/T8FBX5/illustration-of-a-robot-wearing-cap-and-holding-a-tray-of-fast-food-choices-from-burger-fries-and-soda-T8FBX5.jpg");
  List<ChatMessage> messages = [];
  final List<ChatUser> _typingUsers = [];

  bool hasMessagingStart = false;

  var apiKey = dotenv.env['GEMINI_API'] as String;

  @override
  void initState() {
    
    super.initState();

    messages.add(ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: "Hello Akshay, How can i help you related to diet?"));
  }

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
            if (!hasMessagingStart)
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
                      'Look Honey what i have prepared for you 😘',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(25),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    const MealInfo(
                      mealTime: 'Breakfast',
                      meal: 'Sunny Side Egg',
                    ),
                    const MealInfo(
                      mealTime: 'Lunch',
                      meal: 'Sunny Side Egg',
                    ),
                    const MealInfo(
                      mealTime: 'Dinner',
                      meal: 'Sunny Side Egg',
                    ),
                  ],
                ),
              ),
            if (!hasMessagingStart)
              GestureDetector(
                onTap: () {
                  setState(() {
                    hasMessagingStart = true;
                  });
                },
                child: Container(
                  height: 40,
                  width: 350,
                  margin: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(40),
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(15),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Ask me anything about diet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            SizedBox(
              height: getProportionateScreenHeight(610),
              child: DashChat(
                
                typingUsers: _typingUsers,
                currentUser: currentUser,
                onSend: _sendMessage,
                messages: messages,
            
                messageOptions: MessageOptions( 
                  containerColor: const Color(0xFF511CCC).withOpacity(0.15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];

      _typingUsers.add(geminiUser);
    });

    try {
      String prompt =
          "You are FoodBot , your Name is 'Yours 😘', a knowledgeable nutrition expert. Please respond exclusively to questions related to diet, nutrition, and healthy eating. Provide responses that are clear, concise, and well-formatted. If a question does not pertain to these topics, kindly remind the user to focus on diet-related subjects.";
      String question = chatMessage.text;

      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final promtparts = TextPart(prompt);
      final questionparts = TextPart(question);
      final content = Content.multi([promtparts, questionparts]);


      model.generateContentStream([content]).listen((event) {

        _typingUsers.remove(geminiUser);
        ChatMessage? lastMessage = messages.firstOrNull;

        if (lastMessage != null && lastMessage.user == geminiUser) {
        
          lastMessage = messages.removeAt(0);
          String respone = event.text!;
          lastMessage.text += respone;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        
        } else {
        
          String response = event.text!;
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}


class MealInfo extends StatelessWidget {
  final String mealTime;
  final String meal;

  const MealInfo({
    required this.mealTime,
    required this.meal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$mealTime: ',
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
