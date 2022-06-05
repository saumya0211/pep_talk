import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pep_talk/db_Helper/db_provider.dart';
import 'package:pep_talk/models/places_blueprint.dart';

class PlaceProvider with ChangeNotifier{
  List<Place> _PlaceListHolder = [];

  List<Place> get PlaceListHolder{
    return [..._PlaceListHolder];
  }

  void AddPlace({
    required String pickedtitle,
    required File pickedVideo,
    required File pickedThumb,
    required String CityName,
    required double Lat,
    required double Long}){
    Place place = Place(
        id: DateTime.now().toString(),
        title: pickedtitle,
        location: PlaceLocation(
            latitude: Lat,
            longitude: Long,
            address: CityName,
        ),
        Vid:pickedVideo,
        Thumb: pickedThumb,);

    _PlaceListHolder.add(place);
    notifyListeners();
    dbHelper.insert('placestore',{
      'id': place.id,
      'title':place.title,
      'video': place.Vid.path,
      'thumbnail' : place.Thumb.path,
      'address': place.location.address,
      'lat' : place.location.latitude,
      'long': place.location.longitude});
  }

  Future<void> fetchAndSetPlaces() async{
    final dataList = await dbHelper.getData('placestore');
    _PlaceListHolder =  dataList.map((PlaceListHolder) => Place(
      location: PlaceLocation(
        latitude:  PlaceListHolder['lat'],
        longitude: PlaceListHolder['long'],
        address: PlaceListHolder['address'],
      ) ,
      Thumb: PlaceListHolder['thumbnail'],
      Vid: PlaceListHolder['video'],
      title: PlaceListHolder['title'],
      id: PlaceListHolder['id'],
    )).toList();
    notifyListeners();
  }

  Place getPlaceByid(String id){
    return _PlaceListHolder.firstWhere((place) => place.id == id);
  }
}