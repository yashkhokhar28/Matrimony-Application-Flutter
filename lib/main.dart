import 'package:flutter/material.dart';
import 'package:matrimony/login/pre_login_page.dart';
import 'package:matrimony/matrimony/add_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreLoginPage(),
    );
  }
}
