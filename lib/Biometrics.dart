import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Biometrics extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BiometricsState();
}

class BiometricsState extends State<Biometrics> {

  bool authenticated = false;
  bool showText = false;

  @override
  void initState() {
    LocalAuthentication().authenticate(localizedReason: "Test").then((value) {
      this.setState(() {
        showText = true;
        authenticated = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (showText == false) {
      return Text("Loading...");
    }

    return CupertinoPageScaffold(
        child: Container(
          width: double.infinity,
          child: Text(authenticated ? "Success!" : "Failed!")
          ),
      );
  }
}