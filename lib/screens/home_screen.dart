import 'package:task/helper/db_helper.dart';
import 'package:task/models/person.dart';
import 'package:task/screens/new_person.dart';
import 'package:task/widgets/empty_view.dart';
import 'package:task/widgets/person_card.dart';
import 'package:task/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
 

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();


  DBHelper dbHelper = DBHelper();
  Future<List<Person>>? persons;

  getdata() async {
    dbHelper.getPersons().then((value) {
      print("list=$value");
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Builder"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(context);
        },
        child: Icon(
           Icons.add,
          size: 35.0,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                initialData: [],
                future: dbHelper.getPersons(),
                builder: (context, snapshot) {
                  return snapshot.data!.length > 0
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // print(snapshot.data[3].toString());
                            return InkWell(
                              splashColor: Colors.orange,
                              onTap: () => _showModalBottomSheet(
                                  context, snapshot.data![index]),
                              child: PersonCard(
                                person: snapshot.data![index],
                              ),
                            );
                            // return;
                          },
                        )
                      : EmptyView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context, Person person) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Container(
        height: 180.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/avatars/user.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProfileTile(
                      title: person.title,
                      subtitle: "abcd",
                      // textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            // Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  // margin: EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewPerson(isEditing: true, person: person),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 25,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Edit Resume",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: InkWell(
                    onTap: () {
                      showDeleteDialog(context, person);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 25,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Delete Resume",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // ),
      ),
    );
  }

  void showAddDialog(BuildContext context) {
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget okButton = ElevatedButton(
      child: Text("Save"),
      onPressed: () async {
        String title = titleController.text;
        titleController.clear();
        Navigator.pop(context);
        Person newPerson = Person(
          title: title,
          creationDateTime:DateTime.now().toString(),
        );
        await dbHelper.insertPerson(newPerson);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewPerson(isEditing: false, person: newPerson),
          ),
        ).then((value) {
          setState(() {});
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Profile title"),
      content: TextFormField(
        autofocus: true,
        controller: titleController,
        decoration: InputDecoration(
//              enabledBorder: UnderlineInputBorder(
//              borderSide: BorderSide(color: Colors.blue),
//            ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
//              border: UnderlineInputBorder(
//                borderSide: BorderSide(color: Colors.blue),
//              ),
          hintText: "Give a title",
        ),
        keyboardType: TextInputType.text,
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showDeleteDialog(BuildContext context, Person person) {
    // set up the button
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget okButton = TextButton(
      child: Text("Delete"),
      onPressed: () async {
        await dbHelper.deletePerson(person.id!);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        },));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Deleting " + person.title! + "'s Profile"),
      content: Text("Are you sure about deleting this profile?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
