import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {

  String mapTheme = '';
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(target: LatLng(28.196734, 77.151407), zoom: 14 );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/mapTheme/night_theme.json').then((value) => mapTheme = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps Theme"),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(
                onTap: (){
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context).loadString('assets/mapTheme/silver_theme.json').then((string){
                      value.setMapStyle(string);
                    });
                  });
                },
                child: Text('Silver')),

            PopupMenuItem(
                onTap: (){
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context).loadString('assets/mapTheme/retro_theme.json').then((string){
                      value.setMapStyle(string);
                    });
                  });
                },
                child: Text('Retro')),

            PopupMenuItem(
                onTap: (){
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context).loadString('assets/mapTheme/night_theme.json').then((string){
                      value.setMapStyle(string);
                    });
                  });
                },
                child: Text('Night')),

            PopupMenuItem(
                onTap: (){
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context).loadString('assets/mapTheme/aubergine_theme.json').then((string){
                      value.setMapStyle(string);
                    });
                  });
                },
                child: Text('Aubergine'))
          ])
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller){
            controller.setMapStyle(mapTheme);
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
