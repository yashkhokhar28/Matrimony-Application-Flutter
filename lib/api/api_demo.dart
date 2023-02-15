import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:matrimony/matrimony/add_user.dart';
import 'package:matrimony/model/user_list_model/user_model.dart';
import 'package:matrimony/model/user_model.dart';
import 'package:matrimony/retrofit/rest_client.dart';

class ApiDemo extends StatefulWidget {
  const ApiDemo({super.key});

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddUser(
                    model: null,
                  ),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<UserListModel>(
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child:
                      Text(snapshot.data!.resultList![index].name.toString()),
                );
              },
              itemCount: snapshot.data!.resultList!.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: getUsers(),
      ),
    );
  }

  Future<Map<String, dynamic>> callEntriesApi() async {
    http.Response res =
        await http.get(Uri.parse("https://api.publicapis.org/entries"));
    Map<String, dynamic> map = jsonDecode(res.body.toString());
    return map;
  }

  Future<UserListModel> getUsers() async {
    final dio = Dio(); // Provide a dio instance
    final client = RestClient(dio);

    UserListModel data =
        UserListModel.fromJson(jsonDecode(await client.getUsers() as String));
    print(data.resultList!.length);
    return data;
  }


}
