import 'package:flash_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/home_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(fontFamily: 'Montserrat-Medium'),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) =>WelcomeScreen(),
        LoginScreen.id : (context) =>LoginScreen(),
        RegistrationScreen.id : (context) =>RegistrationScreen(),
        HomeScreen.id : (context)=>HomeScreen(),
        ChatScreen.id : (context) =>ChatScreen(),


      }
    );
  }
}
