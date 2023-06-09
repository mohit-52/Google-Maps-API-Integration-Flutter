import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageMarkerScreen extends StatefulWidget {
  const NetworkImageMarkerScreen({Key? key}) : super(key: key);

  @override
  State<NetworkImageMarkerScreen> createState() => _NetworkImageMarkerScreenState();
}

class _NetworkImageMarkerScreenState extends State<NetworkImageMarkerScreen> {

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(target: LatLng(28.196734, 77.151407), zoom: 14 );

  final Set<Marker> _marker = {};

  List<LatLng> _latlng = [
    LatLng(28.199314, 77.152275),
    LatLng(28.4089, 77.3178),
    LatLng(28.1473, 77.3260),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for(int i =0; i<_latlng.length; i++){

      Uint8List? image = await loadNetworkImage('data:image/png;base64,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');

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetWidth: 300,
        targetHeight: 200
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(format:  ui.ImageByteFormat.png);

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

      _marker.add(
        Marker(markerId: MarkerId(i.toString()),
        position: _latlng[i],
          infoWindow: InfoWindow(
            title: "This is marker no $i"
          ),
          icon: BitmapDescriptor.fromBytes(resizedImageMarker)
        )
      );

      setState(() {

      });

    }

  }
  Future<Uint8List> loadNetworkImage(String path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info,_) => completed.complete(info))
    );

    final imageInfo = await completed.future;

    final byteCode = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteCode!.buffer.asUint8List();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(_marker),
          
        ),
      ),
    );
  }
}
