import 'package:task/models/person.dart';
import 'package:task/pages/nested_views/add_reference.dart';
import 'package:flutter/material.dart';
 

class Reference extends StatefulWidget {
  bool? isEditing;
  Person? person;

  Reference({this.isEditing, this.person});

  @override
  _ReferenceState createState() => _ReferenceState();
}

class _ReferenceState extends State<Reference> {
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
            takeToAddReference();
          },
        ),
      ),
    );
  }

  takeToAddReference() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReference(),
      ),
    );
  }
}
