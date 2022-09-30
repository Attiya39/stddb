import 'package:flutter/material.dart';
import 'package:stddb/modeldb/database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database',
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseUser.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();

  void initState() {
    super.initState();

    nameController.text = "";
    ageController.text = "";
    //phoneController.text = "";
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    ageController.dispose();
    //phoneController.dispose();
  }

  void insertData() async {
    Map<String, dynamic> row = {
      DatabaseUser.Name: "Aleena",
      DatabaseUser.Age: 5,
    };
    final id = await dbHelper.insert(row);
    print(id);
  }

  void queryall() async {
    var allrows = await dbHelper.queryAll();
    allrows.forEach((row) {
      print(row);
    });
  }

  void queryspecific() async {
    var allrows = await dbHelper.queryspecific(18);
    print(allrows);
  }

  void update() async {
    var row = await dbHelper.UpdateRecord(2);
    print(row);
  }

  void deleteData() async {
    var id = await dbHelper.DeleteRecord(2);
    print(id);
  }

  void getCount() async {
    var cn = await dbHelper.getCount();
    print(cn);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle btnStyle = TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: "Verdana",
        fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Id",
                labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Verdana"),
                border: OutlineInputBorder(),
                hintText: 'Enter Your Id',
                hintStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Verdana"),
                border: OutlineInputBorder(),
                hintText: 'Enter Your Name',
                hintStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Age",
                labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Verdana"),
                border: OutlineInputBorder(),
                hintText: 'Enter Your Age',
                hintStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: insertData,
                  color: Colors.lightBlueAccent,
                  child: Text(
                    "INSERT",
                    style: btnStyle,
                  ),
                ),
                RaisedButton(
                  onPressed: update,
                  color: Colors.lightBlueAccent,
                  child: Text(
                    "UPDATE",
                    style: btnStyle,
                  ),
                ),
                RaisedButton(
                  onPressed: deleteData,
                  color: Colors.lightBlueAccent,
                  child: Text(
                    "DELETE",
                    style: btnStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
