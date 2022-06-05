import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  MessageBubble(this.Msg,this.Sender,this.isMe);

  String Msg;
  String Sender;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(Sender,style: TextStyle(fontSize: 11,color: Colors.black54),),
          Material(
            elevation: 5,
            color: isMe? Colors.pinkAccent : Colors.lightBlueAccent,
            borderRadius: isMe? BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)) :
            BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Text(Msg),
            ),
          ),
        ],
      ),
    );
  }
}