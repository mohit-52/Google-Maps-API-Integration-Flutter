import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  List<Marker> _marker = [];
  List<Marker> _list =  [
    Marker(markerId : MarkerId('1'),
        position : LatLng(28.198510,77.149222),
    infoWindow: InfoWindow(
      title: "My Home"
    )),
    Marker(markerId : MarkerId('1'),
        position : LatLng(27.198510,76.149222),
        infoWindow: InfoWindow(
            title: "My Home"
        ))
  ];

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(27.198510,76.149222),
    zoom: 14.4746,
  );


  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GoogleMap(initialCameraPosition: _kGooglePlex,
            mapType: MapType.hybrid,
            compassEnabled: false,

            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on_outlined,),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(28.198510,77.149222),
            zoom: 15,)
          ));
        },
      ),
    );
  }
}
