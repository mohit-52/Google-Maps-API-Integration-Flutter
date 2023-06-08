import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {

  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '1122334';
  List<dynamic> _placesList = [];


  @override
  void initState() {
    super.initState();
    
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if(_sessionToken == null){
     setState(() {
       _sessionToken = uuid.v4();
     });
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$baseUrl?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken";

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    print("Data: ") ;
    print(data) ;
    if(response.statusCode == 200){
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];

      });
    }else{
      throw Exception("Failed to autocomplete");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Google Search Places API"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search Places With Name"
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: () async {
                      List<Location> locations = await locationFromAddress(_placesList[index]['description']);

                      print(locations.last.latitude);
                      print(locations.last.longitude);

                    },
                    title: Text(_placesList[index]['description']),
                  );
            }))
          ],
        ),
      ),
    );
  }
}
