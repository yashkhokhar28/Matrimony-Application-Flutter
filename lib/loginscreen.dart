import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool pass = true;
  bool? check2 = true, check3 = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  Container(color: Color(0x99ffffff),),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Image.asset(
                            "assets/images/bharatmatrimony-logo.png",
                            alignment: Alignment.topCenter,
                            width: 220,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Password",
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                              child: TextField(
                                obscureText: pass,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (pass) {
                                            pass = false;
                                          } else {
                                            pass = true;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        pass == true
                                            ? Icons.remove_red_eye
                                            : Icons.password,
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                    activeColor: Colors.black,
                                    value: check2,
                                    controlAffinity:
                                    ListTileControlAffinity.leading,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        check2 = value;
                                      });
                                    },
                                    title: Text("Remember Me"),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
