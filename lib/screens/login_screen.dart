import 'package:flash_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../components/round_btn.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final pswTextcontroller = TextEditingController();
  bool showSpinner = false;

   final _auth = FirebaseAuth.instance;


   String email;
   String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email =value;
                },
                decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your Email') ,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: pswTextcontroller,
                obscureText: true,
                onChanged: (value) {
                  password=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password') ,
              ),
              SizedBox(
                height: 4.0,
              ),
               new RoundedButton(color: Color.fromRGBO(1,214,89,1),title: 'Log In',onPressed: () async {

                 setState(() {
                   showSpinner = true;
                 });
                 try{
                   final user = await _auth.signInWithEmailAndPassword(email: email,password: password);
                   if(user != null){
                     pswTextcontroller.clear();
                     Navigator.pushNamed(context, HomeScreen.id);
                     setState(() {
                       showSpinner =false;
                     });
                   }
                 }catch(e){
                   print(e);
                   kErrorMsgAlert(context).show();
                   setState(() {
                       showSpinner =false;
                     });
                   
                 }
               },),
               SizedBox(
                height: 4.0,
              ),
              Center(child: Text('Or',style: TextStyle(color: Colors.black54),),),
              
              Center(child: Text('Sign In With',style: TextStyle(color: Colors.black54),),),
              

                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: (){},
                          child: Image.asset('images/google.png',height: 45,width: 45,),
                          
                         
                          
                        ),
                        Text('Or',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 30.0),),

                        MaterialButton(
                          onPressed: (){},
                          child: Image.asset('images/facebook-new.png',height: 50,width: 50,),
                          
                          
                          
                        )
                      ],
                  ),
                   ),
                
            


            ],
          ),
        ),
      ),
    );
  }
}
