import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(target: LatLng(28.196734, 77.151407), zoom: 14 );

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> _latlng = [
    LatLng(28.196734, 77.151407),
    LatLng(28.199314, 77.152275),
    LatLng(28.4089, 77.3178),
    LatLng(28.1473, 77.3260),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i= 0; i<_latlng.length; i++){
      _marker.add(
        Marker(markerId: MarkerId(i.toString()),
        position: _latlng[i],
        infoWindow: InfoWindow(
          title: "Really Cool Place",
          snippet: "5 Star Rating"
        ),
        icon: BitmapDescriptor.defaultMarker),
      );

      setState(() {
        
      });
    }
    
    _polyline.add(Polyline(polylineId: PolylineId('1'),
    points: _latlng,
    color: Colors.red),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polyline"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: _marker,
        myLocationEnabled: true,
        mapType: MapType.normal,
        polylines: _polyline,



      ),
    );
  }
}
