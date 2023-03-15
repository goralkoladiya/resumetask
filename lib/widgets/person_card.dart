import 'dart:io';

import 'package:task/helper/db_helper.dart';
import 'package:task/models/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PersonCard extends StatefulWidget {
   Person? person;

  PersonCard({this.person});

  @override
  _PersonCardState createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  TextEditingController titleController = TextEditingController();

  DBHelper dbHelper = DBHelper();
  String? title;

  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage("assets/avatars/user.png"),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      widget.person!.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () => convertToPdf(),
                    child: Text(
                      "Convert to PDF",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.person!.creationDateTime.toString(),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      title = widget.person!.title;
                    });
                    showTitleUpdateDialog(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16.0),
                      SizedBox(width: 10.0),
                      Text("Edit Title"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  convertToPdf() async {
    print("hello");
    if (await Permission.storage.request().isGranted) {
      savePdf();
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      // savePdf();
    }
  }

  savePdf() {
    if(widget.person!.firstName!=null && widget.person!.surname!=null && widget.person!.address!=null &&
        widget.person!.address!=null && widget.person!.aboutMe!=null && widget.person!.phone!=null &&
        widget.person!.country!=null && widget.person!.city!=null )
      {
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  pw.Text(
                    "${"FirstName" + " :" + widget.person!.firstName! +" " + widget.person!.surname!}",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Divider(indent: 10, endIndent: 10),
                  pw.Text(
                    "${"Address" + " :" + widget.person!.address!}",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "${"About" + " :" + widget.person!.aboutMe!}",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "${"Contact" + " :" + widget.person!.phone!}",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "${"Address" + " :" + widget.person!.address!}",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "${"City" + " :" + widget.person!.city!}",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "${"Country" + " :" + widget.person!.country!}",
                    style: pw.TextStyle(
                      fontSize: 20.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ); // Center
            },
          ),
        );
        showGiveNameDialog(context);
      }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 3),
            content: Text('Details are not filled')));
      }


  }

  showGiveNameDialog(BuildContext context) {
    String name= DateTime.now().toString();


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Resume title"),
      content: TextFormField(
        autofocus: true,
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          hintText: widget.person!.title,
        ),
      ),
      actions: [TextButton(
        child: Text("Save"),
        onPressed: () async {
          final File file = File("/storage/emulated/0/Download/$name.pdf");
          await file.writeAsBytes(await pdf.save());
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("PDF Saved"),
          ));
        },
      ), TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      )],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showTitleUpdateDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      // builder: (BuildContext context) {
      //   return alert;
      // },
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Profile title"),
              content: TextFormField(
                autofocus: true,
                controller: titleController..text = title!,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: "New title",
                ),
                keyboardType: TextInputType.text,
              ),
              actions: [
                TextButton(
                  child: Text("Update"),
                  onPressed: () async {
                    await dbHelper.updateTitle(widget.person!.id!, titleController.text);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
