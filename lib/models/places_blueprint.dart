import 'dart:io';

class PlaceLocation{
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude ,
    required this.longitude,
    required this.address ,
  });
}

class Place{
  final String id;
  final String title;
  final PlaceLocation location;
  final File Vid;
  final File Thumb;


  Place({
    required this.id,
    required this.title,
    required this.Vid,
    required this.Thumb,
    required this.location });
}