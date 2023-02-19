import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/database/database.dart';
import 'package:matrimony/model/city_model.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/model/user_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:matrimony/model/user_list_model/user_model.dart';
import 'package:matrimony/retrofit/rest_client.dart';

class AddUser extends StatefulWidget {
  late UserModel? model;

  AddUser({required this.model});

  @override
  State<AddUser> createState() => _AddUserState();
}

String getDateTime(dateToFormat) {
  if (dateToFormat != null) {
    return DateFormat('dd-MM-yyyy').format(dateToFormat).toString();
  } else {
    return DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  }
}

class _AddUserState extends State<AddUser> {
  late TextEditingController name;

  // TextEditingController(text: widget.model!.Name.toString()
  late CityModel model =
      CityModel(CityID1: -1, CityName1: "Select City", StateID1: 1);
  bool isGetCity = true;
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please select city"),
      actions: [
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

  @override
  void initState() {
    super.initState();
    name = TextEditingController(
        text: widget.model != null ? widget.model!.Name.toString() : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New User"),
        backgroundColor: Color.fromARGB(255, 142, 196, 74),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().length == 0) {
                            return 'Enter Valid Name';
                          }
                          return null;
                        },
                        controller: name,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Enter Name",
                            labelStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(1969, 1, 1),
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      _selectedDate = newDateTime;
                    });
                  },
                ),
              ),
              Text(
                _selectedDate ==
                        null //ternary expression to check if date is null
                    ? 'No date was chosen!'
                    : 'Picked Date  :  ${getDateTime(_selectedDate)}',
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                child: FutureBuilder<List<CityModel>>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      if (isGetCity) {
                        model = snapshot.data![0];
                      }
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          items: snapshot.data!
                              .map((item) => DropdownMenuItem<CityModel>(
                                    value: item,
                                    child: Text(
                                      item.CityName.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: model,
                          onChanged: (value) {
                            setState(() {
                              isGetCity = false;
                              model = value!;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down_outlined,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  future:
                      isGetCity ? MyDatabase().getCityListFromTable() : null,
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: TextButton(
                  onPressed: () {
                    setState(
                      () async {
                        if (_formKey.currentState!.validate()) {
                          if (model.CityID == -1) {
                            showAlertDialog(context);
                          } else {
                            addUser();
                            // await MyDatabase().upsertIntoUserTable(
                            //     cityID: model.CityID,
                            //     userName: name.text.toString(),
                            //     dob: _selectedDate.toString(),
                            //     userID: widget.model != null
                            //         ? widget.model!.UserID
                            //         : -1);
                          }
                        }
                      },
                    );
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    final dio = Dio(); // Provide a dio instance
    final client = RestClient(dio);
    await client.addUser(name.text, "", model.CityName).then(
      (value) {
        print(value.toString());
      },
    );
  }
}
