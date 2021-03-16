import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Biometrics.dart';
import 'package:flutterapp/Camera.dart';
import 'package:flutterapp/Location.dart';
import 'package:flutterapp/Notification.dart' as N;
import 'package:flutterapp/Storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )
        )
      ),
      home: Homepage(),
    );
  }
}


class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return (
      Text("fsdf")
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
      CupertinoPageScaffold(
        child: Container(
          width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: CupertinoButton(child: Text("Camera"), onPressed: () {
                    showCupertinoModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      expand: true,
                      bounce: true,
                      builder: (context) => Camera(),
                    );
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoButton(child: Text("Storage"), onPressed: () {
                    showCupertinoModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      expand: true,
                      bounce: true,
                      builder: (context) => Storage(),
                    );
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoButton(child: Text("Location"), onPressed: () {
                    showCupertinoModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      expand: true,
                      bounce: true,
                      builder: (context) => Location(),
                    );
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoButton(child: Text("Biometrics"), onPressed: () {
                    showCupertinoModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        expand: true,
                        bounce: true,
                        builder: (context) => Biometrics(),
                    );
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoButton(child: Text("Notification"), onPressed: () {
                    showCupertinoModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      expand: true,
                      bounce: true,
                      builder: (context) => N.Notification(),
                    );
                  },),
                ),
              ],
          )
      ),
      )
    );
  }
}
