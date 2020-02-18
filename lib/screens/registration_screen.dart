import 'package:flash_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../components/round_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/components/usermanagement.dart';

FirebaseUser loggedInUser;

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  
   String email;
   
   String password;
   String username;
   final _formKey = GlobalKey<FormState>();

    void initState() {
    
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try
      {final user = await _auth.currentUser();
    if(user != null){
       loggedInUser = user;
      
    }
    }catch(e){
      print(e);
      kErrorMsgAlert(context).show();
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key:_formKey,
            autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag:'logo',
                    child: Container(
                      height: 150.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                   validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                   email = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: Validators.compose([
                  Validators.required('Password is required'),
                  
                ]),
                  obscureText: true,
                  onChanged: (value) {
                    password=value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                 SizedBox(
                  height: 8.0,
                ),

                 TextFormField(
                  
                  validator: (value) {
                  if(value.length <= 5){
                    return 'Username should be atleast 5 characters.';
                  }
                  return null;
                },
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Username',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
               new RoundedButton(color: Color.fromRGBO(1,214,89,1),title: 'Register',onPressed: ()async {
                 setState(() {
                   showSpinner = true;
                 });
                try
                { 
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email,password: password).then((loggedInUser){
                    UserManagement().storeNewUser(loggedInUser, context);
                  }).catchError((e){
                    print(e);
                  });
                  
                  if(newUser != null) {
                    Navigator.pushNamed(context, HomeScreen.id);
                  }
                  setState(() {
                    showSpinner= false;
                  });
                }

                

                  catch(e){
                    print(e.message);
                    kErrorMsgAlert(context).show();
                    
                    setState(() {
                    showSpinner= false;
                  });
                  }
                  
               },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
