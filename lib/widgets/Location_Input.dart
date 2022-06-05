import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:pep_talk/models/places_blueprint.dart';

import 'package:pep_talk/models/Network Helper.dart';

 final apikey = ' LPLOTuqCjIHCQlEakuoLw6sB5OryB9qo';
 final LoCapiKey = '703352defe557d914eeb9ae20b12a8cf';

class LocationInput extends StatefulWidget {
  Function onSelected;
  LocationInput({required this.onSelected});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String ? _previewUrlImage;
  PlaceLocation ? City;

  Future<void> _getCurrentLocation() async{
    final locationData = await Location().getLocation();
    var mapimage = await'https://open.mapquestapi.com/staticmap/v4/getmap?key=$apikey&size=400,800&zoom=14&center=${locationData.latitude!},${locationData.longitude!}&mcenter=${locationData.latitude!},${locationData.longitude!}';
    NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/geo/1.0/reverse?lat=${locationData.latitude!}&lon=${locationData.longitude!}&limit=5&appid=$LoCapiKey');

    var weatherData = await networkHelper.getData();

     setState(() {
       _previewUrlImage = mapimage;
       City = PlaceLocation(
           latitude: locationData.latitude!,
           longitude: locationData.longitude!,
           address: weatherData[0]["name"]);
     });
    widget.onSelected(City);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 325,
          width: double.infinity,
          child: _previewUrlImage == null
              ? Center(child: Text('No Location Chosen', textAlign: TextAlign.center,)) :
             Image.network(_previewUrlImage!,
             height: 200,
             width: double.infinity,
             fit: BoxFit.cover,),
          decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(onPressed: (){
              _getCurrentLocation();
            },
                shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.amberAccent)
                      ),
                color: Colors.amber,
                icon: Icon(Icons.location_on),
                label: Text('Current Location')),

          ],
        ),
      ],
    );
  }
}
