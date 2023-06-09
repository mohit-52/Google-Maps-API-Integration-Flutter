import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {

  Completer<GoogleMapController> _controller = Completer();

  List<LatLng> _points = [
    LatLng(28.196734, 77.151407),
    LatLng(28.197849, 77.148574),
    LatLng(28.199929, 77.149786),
    LatLng(28.199314, 77.152275),
  LatLng(28.196734, 77.151407),

  ];

  static const CameraPosition _kGooglePlex =
  CameraPosition(target: LatLng(28.196734, 77.151407), zoom: 15 );

  final Set<Marker> _markers = {};
  final Set<Polygon> _polyogn = HashSet<Polygon>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polyogn.add(
      Polygon(polygonId: PolygonId('1'),
      points: _points,
      geodesic: true,
      fillColor: Colors.red.withOpacity(1),
      strokeWidth: 4)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polygon"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        polygons: _polyogn,

        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
