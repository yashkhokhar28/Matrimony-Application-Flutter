import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/database/database.dart';
import 'package:matrimony/matrimony/add_user.dart';
import 'package:matrimony/model/user_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  MyDatabase db = MyDatabase();
  List<UserModel> localList = [];
  List<UserModel> searchList = [];
  bool isGetData = true;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    MyDatabase().copyPasteAssetFileToRoot().then(
      (value) {
        MyDatabase().getUserListFromTable();
      },
    );
    super.initState();
  }

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
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<UserModel>>(
          builder: (context, snapshot) {
            if (snapshot != null && snapshot.hasData) {
              if (isGetData) {
                localList.addAll(snapshot.data!);
                searchList.addAll(localList);
              }
              isGetData = false;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        searchList.clear();
                        for (int i = 0; i < localList.length; i++) {
                          if (localList[i]
                              .Name
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            searchList.add(localList[i]);
                          }
                        }
                        setState(() {});
                      },
                      decoration: InputDecoration(hintText: 'Search User'),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (builder) =>
                                      AddUser(model: searchList![index]),
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
                                      InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                        onTap: () {
                                          showAlertDialog(context, index);
                                        },
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index].Name
                                                    .toString(),
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                snapshot.data![index].DOB
                                                    .toString(),
                                                style: GoogleFonts.openSans(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            searchList[index].isFavouriteUser =
                                                !searchList[index]
                                                    .isFavouriteUser;
                                          });
                                        },
                                        child: Icon(
                                            searchList[index].isFavouriteUser
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red.shade400,
                                            size: 24),
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
                      itemCount: searchList!.length,
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("No Data Found"),
              );
            }
          },
          future: isGetData ? MyDatabase().getUserListFromTable() : null,
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, index) {
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        int deletedUserID =
            await db.deleteUserFromUserTable(localList[index].UserID);
        if (deletedUserID > 0) {
          localList.removeAt(index);
        }
        Navigator.pop(context);
        setState(() {});
      },
    );
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure want to delete?"),
      actions: [
        yesButton,
        noButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
