import 'package:flutter/material.dart';
import 'package:matrimony/database/database.dart';
import 'package:matrimony/matrimony/add_user.dart';
import 'package:matrimony/model/city_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddUser(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 142, 196, 74),
        title: Text("User List"),
      ),
      body: Center(
        child: FutureBuilder<List<CityModel>>(
          builder: (context, snapshot) {
            if (snapshot != null && snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      children: [
                        Text(
                          snapshot.data![index].CityName.toString(),
                        ),
                        Text(
                          snapshot.data![index].CityID.toString(),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return Center(
                child: Text("No Data Found"),
              );
            }
          },
          future: MyDatabase().getCityListFromTable(),
        ),
      ),
    );
  }
}
