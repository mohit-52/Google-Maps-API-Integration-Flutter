import 'package:flutter/material.dart';
import 'package:google_maps/user_current_location.dart';

import 'convert_latlng_to_address.dart';
import 'google_places_api.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const GooglePlacesApiScreen(),
    );
  }
}
