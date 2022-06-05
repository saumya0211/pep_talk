import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pep_talk/Screens/login_screen.dart';
import 'package:pep_talk/Screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pep_talk/components/NavButton.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static String id = 'welcome_screen';
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{

  late AnimationController c ;

  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this,
    duration: Duration(seconds: 1));
    c.forward();
    c.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    c.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png'),
                  height: 60.0,
                ),
                TextLiquidFill(
                  boxHeight: 70,
                  boxWidth: 300,
                  boxBackgroundColor: Colors.white,
                  waveColor: Colors.amber.shade700,
                  text: 'Vid Go',
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            // NavButton(
            //   c: Colors.lightBlueAccent,
            //   v: (){Navigator.pushNamed(context, LoginScreen.id);},
            //   s: 'Log In',),

            NavButton(
                c: Colors.brown,
                v: (){Navigator.pushNamed(context,RegistrationScreen.id);},
                s: 'Log In'),
          ],
        ),
      ),
    );
  }
}

