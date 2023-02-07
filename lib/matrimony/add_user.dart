import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:matrimony/database/database.dart';
import 'package:matrimony/model/city_model.dart';
import 'package:intl/intl.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

String getDateTime() {
  return DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
}


class _AddUserState extends State<AddUser> {
  late CityModel model =
      CityModel(CityID1: -1, CityName1: "Select City", StateID1: 1);
  bool isGetCity = true;

  @override
  void initState() {
    super.initState();
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
          TextFormField(),
          InkWell(
            onTap: () {

            },
            child: Text(
              getDateTime(),
            ),
          ),
          SizedBox(
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
              future: isGetCity ? MyDatabase().getCityListFromTable() : null,
            ),
          ),
        ],
      ),
    );
  }
}
