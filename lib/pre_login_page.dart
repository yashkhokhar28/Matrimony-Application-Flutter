import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreLoginPage extends StatelessWidget {
  const PreLoginPage({super.key});

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
                  Container(
                    margin: EdgeInsets.only(top: 75),
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
                    margin: EdgeInsets.only(top: 165),
                    child: Text(
                      "INDIA'S\nMOST TRUSTED\nMATRIMONY BRAND\n",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 1.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    child: Text(
                      "BY THE BRAND TRUST REPORT 2014",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontSize: 15,
                        wordSpacing: 1,
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                        decoration: TextDecoration.combine([
                          TextDecoration.overline,
                          TextDecoration.underline
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 142, 196, 74),
                    child: TextButton(
                      onPressed: null,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 48, 48, 48),
                    child: TextButton(
                      onPressed: null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
