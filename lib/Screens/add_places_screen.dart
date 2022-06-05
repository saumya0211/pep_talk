import 'dart:io';
import 'package:pep_talk/models/places_blueprint.dart';
import 'package:pep_talk/providers/place_provider.dart';
import 'package:pep_talk/widgets/Location_Input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pep_talk/widgets/Image_Input.dart';

class AddScreen extends StatelessWidget {

 TextEditingController _TitleTextController = TextEditingController();

 File ? _CurrentVideo;
 PlaceLocation ?_CurrentCity;
 File ?_CurrentThumbnail;

 void CallCurrentImage(File CurrentVideo,File CurrentThumbnail){
   if(CurrentVideo!=null && CurrentThumbnail!=null){
       _CurrentVideo = CurrentVideo;
       _CurrentThumbnail = CurrentThumbnail;
   }
 }

 void CallCurrentCity(PlaceLocation City){
   if(City!= null){
     _CurrentCity = City;
   }
 }
  @override
  Widget build(BuildContext context) {

    void SafePlace(){
      if(_TitleTextController.text == null || _CurrentThumbnail == null || _CurrentCity ==null){
        throw Text('One of the field missing : Title, Video or Location');
      }else {
        Provider.of<PlaceProvider>(context, listen: false).AddPlace(
          Long: _CurrentCity!.longitude,
          pickedtitle: _TitleTextController.text,
          pickedVideo: _CurrentVideo!,
          pickedThumb:  _CurrentThumbnail!,
          CityName: _CurrentCity!.address,
          Lat:  _CurrentCity!.latitude,
          );
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child:SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        maxLength: 25,
                        decoration: InputDecoration(label: Text('Title...')),
                        controller: _TitleTextController,
                      ),
                      SizedBox(height: 20,),
                      ImageInput(onSelected: CallCurrentImage),
                      SizedBox(height: 20,),
                      LocationInput(onSelected: CallCurrentCity),
                    ],
                  ),
                ),
              ) ),

          RaisedButton.icon(
            onPressed: (){
              SafePlace();
            },
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
