import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationService;

class Location extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationState();
}

class LocationState extends State<Location> {

  LocationService.Location location = new LocationService.Location();

  bool _serviceEnabled = false;
  LocationService.LocationData _locationData;

  CameraPosition _cameraPosition;

  Set<Circle> _circles = Set<Circle>();

  StreamSubscription<LocationService.LocationData> _locationSubscription;

  @override
  void initState() {
    location.serviceEnabled().then((value) {
      if (value == false) {
        location.requestService().then((value) {
          this.setState(() {
            _serviceEnabled = value;
          });
        });
      }

      this.setState(() {
        _serviceEnabled = value;
      });
    });


    _locationSubscription = location.onLocationChanged.listen((event) {
      this.setState(() {
        _locationData = event;
        _circles.clear();
        _circles.add(Circle(
            center: LatLng(event.latitude, event.longitude),
            circleId: CircleId("1"),
            fillColor: Colors.yellow,
            strokeColor: Colors.yellow,
            radius: 5000,
            strokeWidth: 5,
        )
        );
      });
    });

    _cameraPosition = CameraPosition(
      target: LatLng(49.8175, 15.4730),
      zoom: 6,
    );

    super.initState();
  }


  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_serviceEnabled == false) {
      return CupertinoPageScaffold(child: Text("Loading..."));
    }

    return CupertinoPageScaffold(
        child: Container(
          width: double.infinity,
          child: _locationData == null ? Text("Loading...") : Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 1,
                  child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _cameraPosition,
                    circles: _circles,
                  )
              )
            ],
          ),
        )
    );
  }
}