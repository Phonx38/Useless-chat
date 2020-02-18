import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/round_btn.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation animation;
  @override
  void initState() {
   
    super.initState();
    controller =  AnimationController(
      
      duration: Duration(seconds: 1),
      vsync: this,
      
    );
    
    animation = ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);

    controller.forward(); 

    

    controller.addListener((){
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height:controller.value * 60,
                  ),
                ),
                Expanded(
                  
                  child: TypewriterAnimatedTextKit(
                    speed: Duration(milliseconds: 500),
                    isRepeatingAnimation: true,
                    text: ['Useless Chat'],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            new RoundedButton(color: Color.fromRGBO(1,214,89,1),title: 'Log In',onPressed: () { Navigator.pushNamed(context, LoginScreen.id);},),

            new RoundedButton(color: Colors.grey[50],title: 'Register',onPressed: () { Navigator.pushNamed(context, RegistrationScreen.id);},),
           
          ],
        ),
      ),
    );
  }
}

