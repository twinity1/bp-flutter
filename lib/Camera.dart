import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class Camera extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  List<CameraDescription> cameras;
  bool showCamera = false;
  CameraDescription camera;

  @override
  void initState() {
    super.initState();

    availableCameras().then((value) => {
      this.setState(() {
        this.cameras = value;
        this.showCamera = true;

        if (this.camera == null) {
          this.camera = this.cameras.first;
        }

        setCameraController();
      })
    });
  }

  void setCameraController() {
    _controller = CameraController(
      this.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Camera oldWidget) {
    setCameraController();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (showCamera == false) {
      return Text("");
    }

    return CupertinoPageScaffold(
      child: Container(
        width: double.infinity,
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 5,
                    child: CameraPreview(_controller),
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(child: Text("Back"), onPressed: () {
                            this.cameras.forEach((element) {
                              if (element.lensDirection == CameraLensDirection.back) {
                                this.setState(() {
                                  this.camera = element;
                                  setCameraController();
                                });
                              }
                            });
                          }),
                          CupertinoButton(child: Text("Capture"), onPressed: () async {
                              final image = await _controller.takePicture();

                              showCupertinoModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                expand: true,
                                bounce: true,
                                builder: (context) => DisplayPictureScreen(
                                  imagePath: image?.path,
                                ),
                              );
                          }),
                          CupertinoButton(child: Text("Front"), onPressed: () {
                            bool found = false;

                            this.cameras.forEach((element) {
                              if (element.lensDirection == CameraLensDirection.front && found == false) {
                                found = true;
                                this.setState(() {
                                  this.camera = element;
                                  setCameraController();
                                });
                              }
                            });
                          }),
                        ],
                      ))
                ],
              );
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
        },
      ),
    )
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Image.file(File(imagePath)),
    );
  }
}