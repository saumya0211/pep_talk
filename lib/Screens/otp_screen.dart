import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  late String OTP;
  TextEditingController _texteditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          Center(
            child:Padding(
              padding: const EdgeInsets.only(top: 10,left: 30,right: 30,),
              child: TextField(
                controller: _texteditor,
                onChanged: (value){
                  OTP = value;
                },
              ),
            ) ,),
          SizedBox(height: 10,),
          FlatButton(onPressed: (){
            Navigator.pop(context,OTP);
          }, child: Text('Check'))
        ],
      ),
    );
  }
}
