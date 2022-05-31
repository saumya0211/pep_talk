import 'package:flutter/material.dart';
import 'package:pep_talk/components/MessageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pep_talk/Screens/chat_screen.dart';

class StreamListView extends StatelessWidget {

  StreamListView(this.UserActive);
  final _firestore = FirebaseFirestore.instance;
  final UserActive ;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream:_firestore.collection('messages').orderBy('timestamp').snapshots(),
        builder: (context,S){
          if(! S.hasData){
            return Center(child: CircularProgressIndicator.adaptive());
          }
          List<MessageBubble> MessageWig = [];
          final message = S.data?.docs.reversed;
          for(var SingleDoc in message!)
          {
            final MessageTxt = SingleDoc.get('text');
            final Sender = SingleDoc.get('sender');
            MessageWig.add(MessageBubble(MessageTxt,Sender,Sender==UserActive));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: MessageWig,
            ),
          );
        } );
  }
}