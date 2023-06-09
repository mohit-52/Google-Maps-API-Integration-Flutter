import 'dart:async';
import 'dart:typed_data' ;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;

  List<String> images = [
    'images/car1.png',
    'images/car2.png',
    'images/car3.png',
    'images/marker1.png',
    'images/marker2.png',
    'images/marker3.png'
  ];

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    LatLng(28.2487, 77.0635),
    LatLng(28.4595, 77.0266),
    LatLng(28.7041, 77.1025),
    LatLng(28.4089, 77.3178),
    LatLng(28.1473, 77.3260),
    LatLng(28.2225, 77.1528)
  ];

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(28.2225, 77.1528), zoom: 15);


  Future<Uint8List> getBytesFromAssets (String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    for (int i = 0; i < _latLng.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _marker.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLng[i],
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(
          title: "This is marker $i"
        )
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ));
  }
}
