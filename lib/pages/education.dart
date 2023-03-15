import 'package:task/models/person.dart';
import 'package:task/pages/nested_views/add_education.dart';
import 'package:flutter/material.dart';
 

class Educational extends StatefulWidget {
  bool? isEditing;
  Person? person;

  Educational({this.isEditing, this.person});

  @override
  _EducationalState createState() => _EducationalState();
}

class _EducationalState extends State<Educational> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            takeToAddEducation();
          },
        ),
      ),
    );
  }

  takeToAddEducation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEducation(),
      ),
    );
  }
}
