import 'package:task/helper/db_helper.dart';
import 'package:task/models/person.dart';
import 'package:flutter/material.dart';
 

class Contact extends StatefulWidget {
  bool? isEditing;
  Person? person;

  Contact({this.isEditing, this.person});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  int id = 0;
  String phoneNumber = "";
  String email = "";
  String address = "";

  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();

    if (widget.isEditing == true) {


      phoneNumberController.value = phoneNumberController.value.copyWith(
        text: widget.person!.phone,
        selection: widget.person!.phone != null
            ? TextSelection.collapsed(offset: widget.person!.phone!.length)
            : null,
      );

      emailController.value = emailController.value.copyWith(
        text: widget.person!.email,
        selection: widget.person!.email != null
            ? TextSelection.collapsed(offset: widget.person!.email!.length)
            : null,
      );

      addressController.value = addressController.value.copyWith(
        text: widget.person!.address,
        selection: widget.person!.address != null
            ? TextSelection.collapsed(offset: widget.person!.address!.length)
            : null,
      );


      id = widget.person!.id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          phoneNumber = phoneNumberController.text;
          email = emailController.text;
          address = addressController.text;
          await dbHelper.updateContactInformation(id, phoneNumber, email,
              address);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 3),
              content: Text('Contact Information Updated')));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              width: (width - 10) / 1,
              child: Theme(
                child: TextFormField(
                  maxLines: null,
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Phone Number",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              width: (width - 10) / 1,
              child: Theme(
                child: TextFormField(
                  maxLines: null,
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              width: (width - 10) / 1,
              child: Theme(
                child: TextFormField(
                  maxLines: null,
                  controller: addressController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.navigation),
                    labelText: "Address",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.blueAccent,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
