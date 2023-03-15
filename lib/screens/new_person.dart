import 'package:task/helper/db_helper.dart';
import 'package:task/models/person.dart';
import 'package:flutter/material.dart';

import '../pages/contact.dart';

import '../pages/personal.dart';


class NewPerson extends StatefulWidget {
   bool? isEditing;
   Person? person;

  NewPerson({this.isEditing, this.person});

  @override
  _NewPersonState createState() => _NewPersonState();
}

class _NewPersonState extends State<NewPerson>
    with SingleTickerProviderStateMixin {
  int personId = 0;
  DBHelper dbHelper = DBHelper();
  TabController? tabController;



  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 8, vsync: this);
  }

  void initiatePerson() async {
    Person person = Person();
    personId = await dbHelper.insertPerson(person);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Information"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TabBar(
              controller: tabController,
              indicatorColor: Colors.blueAccent,
              indicatorWeight: 3.0,
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Personal",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Tab(
                  child: Text(
                    "Contact",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    Personal(isEditing: widget.isEditing, person: widget.person),
                    Contact(isEditing: widget.isEditing, person: widget.person),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
