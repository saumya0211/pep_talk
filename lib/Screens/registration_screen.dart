import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pep_talk/Screens/chat_screen.dart';
import 'package:pep_talk/Screens/places_list_screen.dart';
import 'package:pep_talk/components/NavButton.dart';
import 'package:pep_talk/constants.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
  static String id = 'registration_screen';
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String PhoneNumber;
  FirebaseAuth __auth = FirebaseAuth.instance;
  bool Spin = false;
  int ? _ResendOTP;
  bool OTPVisible = false;
  String ? OTP;
  TextEditingController phonecontroller = TextEditingController();

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
                controller: phonecontroller,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {

                  PhoneNumber = value;
                },
                decoration: KPasswordDecoration,
              ),
              SizedBox(
                height: 24.0,
              ),

              Visibility(
                visible: OTPVisible,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      OTP = value;
                    });
                  },
                  decoration: KEmailDecoration,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),

              NavButton(c: Colors.brown, v: () async{
              try{

                   phoneVerification();
              }catch(e){
                print(e);
              }

              }, s: OTPVisible ? 'Register' : 'Verify'),
            ],
          ),
        ),
      ),
    );

    }
  void phoneVerification() async{
    await __auth.verifyPhoneNumber(
        forceResendingToken: _ResendOTP,
        timeout: Duration(minutes: 2),
        phoneNumber: phonecontroller.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await __auth.signInWithCredential(credential);
        },
        verificationFailed:  (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          return;
        },
        codeSent: (String verificationId, resendCode) async {
          setState(() {
            OTPVisible = true;
          });

             PhoneAuthCredential credential = await PhoneAuthProvider.credential(
                 verificationId: verificationId,
                 smsCode: OTP!);

                Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaceListScreen()));

               _ResendOTP = resendCode;
         },
        codeAutoRetrievalTimeout: (verification_id){
          print('Timeout');
                verification_id = '';
    });
  }
}

