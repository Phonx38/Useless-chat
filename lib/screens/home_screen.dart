import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/round_btn.dart';


class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:Color.fromRGBO(1,214,89,1),
        leading: null,
        title: Text('Useless Chat',textAlign: TextAlign.center,),
      ),
      body: SafeArea(
        child: Center(
        
            child: Column(
              
              
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 100.0, 8.0, 8.0),
                  child: Container(
                    child: new Align(alignment: Alignment.centerLeft, child: new Text("Hello,",style: TextStyle(color: Colors.black,fontSize: 50.0),))
                  
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                    child: Container(
                      child: new Align(alignment: Alignment.centerLeft, child: new Text("This is a totally Useless chat app.",style: TextStyle(color: Colors.black54,fontSize: 30.0),))
                    
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
                new RoundedButton(color: Color.fromRGBO(1,214,89,1),title: 'Chat',onPressed: () { Navigator.pushNamed(context, ChatScreen.id);},),
                SizedBox(
                  height: 30.0,
                ),
               
              ],
            ),
         
        ),
      ),
    );
  }
}