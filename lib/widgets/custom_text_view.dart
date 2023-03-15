import 'package:flutter/material.dart';
 

class CustomTextView extends StatelessWidget {
  String? title;

  CustomTextView({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black12,
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.add,
              size: 30.0,
              color: Colors.lightGreen,
            ),
          ),
          SizedBox(width: 5.0),
          Text(title!),
        ],
      ),
    );
  }
}
