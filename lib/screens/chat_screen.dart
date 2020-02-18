import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
 static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
} 

class _ChatScreenState extends State<ChatScreen> {
  final msgTextcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  Timestamp time;
  String messageText;
  @override
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
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(1,214,89,1),
        leading: null,
        actions: <Widget>[
          MaterialButton( 
              elevation: 5.0,
              child: Text('Logout',style: TextStyle(color: Colors.white),),
              onPressed: () {
                _auth.signOut();
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTextcontroller,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      msgTextcontroller.clear();
                      _firestore.collection('messages').add({
                        'text' : messageText,
                        
                        'sender' : loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context,snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                  final messages = snapshot.data.documents.reversed;
                  List<MessageBubble> messageBubbles = [];
                  for(var message in messages){
                    final messageText = message.data['text'];
                    final messageSender = message.data['sender'];
                    
                    final currentUser = loggedInUser.email;

                    final messageBubble = MessageBubble(sender: messageSender,text: messageText,isMe: currentUser ==messageSender,);
                        
                    messageBubbles.add(messageBubble);
                    // if(messages.length > 0){
                    //   messageBubbles.sort((a , b ) => b.time.compareTo(a.time));
                    // }
                    
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                      children: messageBubbles,
                    ),
                  );
                }
              
            );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    this.sender,
    
    this.text,
    this.isMe,
  });

  final String sender;
  final String text;

  final bool isMe ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$sender ",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),

          Material(
            elevation: 5.0,
            borderRadius: 
              isMe ? BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))
              :  BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0),topRight: Radius.circular(30.0)),
            color: isMe ?  Color.fromRGBO(1,214,89,1) : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Text(
                '$text ',
                style: TextStyle(
                  color:  isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}