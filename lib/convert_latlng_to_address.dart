import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatlngToAddress extends StatefulWidget {
  const ConvertLatlngToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatlngToAddress> createState() => _ConvertLatlngToAddressState();
}

class _ConvertLatlngToAddressState extends State<ConvertLatlngToAddress> {
  @override
  Widget build(BuildContext context) {

    String stAddress = '', stAdd = '';
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress, style: TextStyle(color: Colors.red, fontSize: 30),),
          Text(stAdd, style: TextStyle(color: Colors.red, fontSize: 30),),
          GestureDetector(
            onTap: () async {

              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);


              setState((){
                stAddress = locations.last.latitude.toString() + locations.last.longitude.toString();
                stAdd = placemarks.reversed.last.country.toString();
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.green
              ),
              height: 50,
              child: Center(child: Text("Convert"),),
            ),
          )
        ],
      ),
    );
  }
}
