import 'package:flutter/material.dart';
import 'package:google_maps/style_google_map_screen.dart';
import 'network_image_marker.dart';

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
      home: const StyleGoogleMapScreen(),
    );
  }
}
