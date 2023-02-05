import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/images/bg_matrimony_prelogin.jpg",
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  color: Color(0x99ffffff),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
