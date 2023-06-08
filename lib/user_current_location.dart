import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(28.2487, 77.0635), zoom: 14);

  final List<Marker> _markers =  <Marker>[
    Marker(markerId: MarkerId('1'),
    position:LatLng(28.2487, 77.0635),
    infoWindow: InfoWindow(title: "My"))
  ];


  loadData() {
    getUserCurrentLocation().then((value) async {
      print("My current location is: ");
      print(value.latitude.toString() + value.longitude.toString());

      _markers.add(
          Marker(markerId: MarkerId('2'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                  title: "My Current Location"
              ))
      );

      CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 18);

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {

      });

    });
  }

  Future<Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value){
      
    }).onError((error, stackTrace){
      print("Error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getUserCurrentLocation().then((value) async {
            print("My current location is: ");
            print(value.latitude.toString() + value.longitude.toString());
            
            _markers.add(
              Marker(markerId: MarkerId('2'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                title: "My Current Location"
              ))
            );

            CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 14);

            final GoogleMapController controller = await _controller.future;
            
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {

            });

          });
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
