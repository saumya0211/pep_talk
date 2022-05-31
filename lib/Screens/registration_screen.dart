import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pep_talk/Screens/chat_screen.dart';
import 'package:pep_talk/components/NavButton.dart';
import 'package:pep_talk/constants.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
  static String id = 'registration_screen';
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String Password;
  FirebaseAuth __auth = FirebaseAuth.instance;
  bool Spin = false;

  @override
  Widget build(BuildContext context) {
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
              NavButton(c: Colors.blueAccent, v: () async{
              try{
                final NewUser = await __auth.createUserWithEmailAndPassword(email: email, password: Password);
                if(NewUser!= null){
                  Navigator.pushNamed(context, ChatScreen.id);
                }
                setState(() {
                  Spin = true;
                });
              }catch(e){
                print(e);
              }

              }, s: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
