import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pep_talk/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pep_talk/components/StreamListView.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static String id = 'chat_screen';
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User ? LoggedInUser;
  late String MessageText;
  bool emojiShowing = false;
  FocusNode focusNode = FocusNode();

  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }
  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  void getCurrentUser() async{
    try{
      final CurrentUser = await _auth.currentUser;
      if(CurrentUser!=null){
        setState(() {
          LoggedInUser = CurrentUser;
        });
      }else{
        LoggedInUser = null;
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            StreamListView(LoggedInUser!.phoneNumber),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        focusNode.unfocus();
                        focusNode.canRequestFocus = false;
                        setState(() {
                           emojiShowing = !emojiShowing;
                        });
                      },
                      icon:Icon(
                        Icons.emoji_emotions,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      controller: _controller,
                      onChanged: (value) {
                        //Do something with the user input.
                          MessageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').add({
                        'sender': LoggedInUser!.phoneNumber,
                        'text' : MessageText,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      _controller.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
        Offstage(
          offstage: !emojiShowing,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
                onEmojiSelected: (Category category, Emoji emoji) {
                  _onEmojiSelected(emoji);
                },
                onBackspacePressed: _onBackspacePressed,
                config: Config(
                    columns: 7,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    progressIndicatorColor: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    // noRecentsText: 'No Recents',
                    // noRecentsStyle: const TextStyle(
                    //     fontSize: 20, color: Colors.black26),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL)),
          ),
        )],
        ),
      ),
    );
  }
}




