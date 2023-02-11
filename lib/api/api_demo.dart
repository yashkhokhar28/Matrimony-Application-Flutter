import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:logger/logger.dart';

// import 'package:retrofit_example/example.dart';
import 'package:dio/dio.dart';
import 'package:matrimony/model/user_model.dart';

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
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Text(
                    snapshot.data.toString(),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: callEntriesApi(),
      ),
    );
  }

  Future<Map<String, dynamic>> callEntriesApi() async {
    http.Response res =
        await http.get(Uri.parse("https://api.publicapis.org/entries"));
    Map<String, dynamic> map = jsonDecode(res.body.toString());
    return map;
  }
}
