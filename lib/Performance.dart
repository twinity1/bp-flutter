import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Performance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PerformanceState();
}

class PerformanceState extends State<Performance> {
  final myController = TextEditingController();

  List<String> data = List.empty(growable: true);

  @override
  void initState() {
    for (var i = 0; i < 10000; i++) {
      data.add("Text .... " + i.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
          width: double.infinity,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                      child: Image(image: AssetImage('image.png'),)
                  ),
                  Expanded(child: Text(data[index])),
                  Expanded(child: CupertinoButton(child: Text("Tap me"), onPressed: () {
                    this.setState(() {
                      data.removeAt(index);
                    });
                  },)),
                ],
              );
            },
            itemCount: data.length,
          ),
          ),
      );
  }
}