import 'package:flutter/material.dart';
import 'package:kinoqahramon_firebase/screens/chat/components/body.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}