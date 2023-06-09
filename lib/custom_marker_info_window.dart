import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLng.length; i++) {
      if(i%2 == 0){
        _marker.add(Marker(
            markerId: MarkerId(i.toString()),
            position: _latLng[i],
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: "This is marker $i"),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://images.pexels.com/photos/259588/pexels-photo-259588.jpeg?auto=compress&cs=tinysrgb&w=600'),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Mohit's Residence",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ),
                              const Spacer(),
                              Text('0.3 Km')
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Text("This is Mohit's Residence, one of the biggest houses of India"),
                        ),
                      ],
                    )),
                _latLng[i],
              );
            }));

      }else{
        _marker.add(Marker(
            markerId: MarkerId(i.toString()),
            position: _latLng[i],
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: "This is marker $i"),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(child: CircleAvatar(
                          radius: 50,
                          backgroundImage:  NetworkImage(
                                  'https://images.pexels.com/photos/259588/pexels-photo-259588.jpeg?auto=compress&cs=tinysrgb&w=600',

                        ),),),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child:  Row(
                            children: const [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Mohit's Residence",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ),
                              Spacer(),
                              Text('0.3 Km')
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Text("This is Mohit's Residence, one of the biggest houses of India"),
                        ),
                      ],
                    )),
                _latLng[i],
              );
            }));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_marker),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            width: 300,
            height: 200,
            offset: 35,
          )
        ],
      ),
    );
  }
}
