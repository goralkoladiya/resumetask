import 'package:task/models/person.dart';
import 'package:task/pages/nested_views/add_experience.dart';
import 'package:flutter/material.dart';
 

class Experience extends StatefulWidget {
  bool? isEditing;
  Person? person;

  Experience({this.isEditing, this.person});

  @override
  _ExperienceState createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: IconButton(
          icon: Icon(
             Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            takeToAddExperience();
          },
        ),
      ),
    );
  }

  takeToAddExperience() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExperience(),
      ),
    );
  }
}
