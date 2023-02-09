import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/database/database.dart';
import 'package:matrimony/matrimony/add_user.dart';
import 'package:matrimony/model/city_model.dart';
import 'package:matrimony/model/user_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  MyDatabase db = MyDatabase();
  List<UserModel> localList=  [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddUser(model: null),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 142, 196, 74),
        title: Text("User List"),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<UserModel>>(
          builder: (context, snapshot) {
            if (snapshot != null && snapshot.hasData) {
              // localList.addAll(snapshot.data)
              return ListView.builder(
                padding: EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => AddUser(model: snapshot.data![index]),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        elevation: 2,
                        borderOnForeground: true,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].Name.toString(),
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          snapshot.data![index].DOB.toString(),
                                          style: GoogleFonts.openSans(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
          future: MyDatabase().getUserListFromTable(),
        ),
      ),
    );
  }
}
