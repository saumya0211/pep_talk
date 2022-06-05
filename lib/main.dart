import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pep_talk/Screens/chat_screen.dart';
import 'package:pep_talk/Screens/login_screen.dart';
import 'package:pep_talk/Screens/registration_screen.dart';
import 'package:pep_talk/Screens/welcome_screen.dart';
import 'package:pep_talk/providers/place_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(FlashChat());}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id : (context) =>WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id : (context) => RegistrationScreen(),
          ChatScreen.id : (context) =>ChatScreen(),
        } ,
      ),
    );
  }
}
