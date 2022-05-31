import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  NavButton({
    required this.c,
    required this.v,
    required this.s,

  });

  final Color c;
  final String s;
  final VoidCallback v;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: c,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: v,
          minWidth: 200.0,
          height: 42.0,
          child: Text(s,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
