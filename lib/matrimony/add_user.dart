import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:matrimony/database/database.dart';
import 'package:matrimony/model/city_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late CityModel model;

  @override
  void initState() {
    super.initState();
    model = CityModel();
    model.CityID = -1;
    model.CityName = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New User"),
        backgroundColor: Color.fromARGB(255, 142, 196, 74),
      ),
      body: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              return Container();
            },
            future: MyDatabase().initDatabase(),
          ),
        ],
      ),
    );
  }
}
