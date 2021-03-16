import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage extends StatefulWidget {
    @override
  State<StatefulWidget> createState() => StorageState();
}

class StorageState extends State<Storage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: CupertinoTextField(controller: myController),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CupertinoButton(child: Text("Save"), onPressed: () async {
                          ContentStorage().write(myController.text);
                      }),
                    ),
                  ],
                )
              ),
              Expanded(
                flex: 1,
                child: CupertinoButton(child: Text("Load"), onPressed: () {
                  ContentStorage().read().then((value) {
                    myController.text = value;
                  });

                })
              ),
            ],
          ),
        )
    );
  }
}

class ContentStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return "";
    }
  }

  Future<File> write(String content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }
}