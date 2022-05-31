import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pep_talk/Screens/chat_screen.dart';
import 'package:pep_talk/components/NavButton.dart';
import 'package:pep_talk/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static String id = 'login_screen';
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String Password;
  bool Spin = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      Spin = false;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Spin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: KEmailDecoration,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  Password = value;
                },
                decoration: KPasswordDecoration,
              ),
              SizedBox(
                height: 24.0,
              ),
              NavButton(c: Colors.lightBlueAccent, v: () async{
                try{
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: Password);
                  if(user!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    Spin = true;
                  });
                }catch(e){
                  print(e);
                }
              }, s: 'Log In'),
            ],
          ),
        ),
      ),
    );
  }
}
