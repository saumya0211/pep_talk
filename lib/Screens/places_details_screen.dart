import 'package:flutter/material.dart';
import 'package:pep_talk/models/places_blueprint.dart';
import 'package:pep_talk/providers/place_provider.dart';
import 'package:pep_talk/widgets/Location_Input.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class DetailsPage extends StatefulWidget {
  String id;
  DetailsPage({required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  late Place SelectedPlace ;
  String ? _previewUrlImage;

 late VideoPlayerController  _controller ;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<String> SetImage() async{
    var mapimage = await await 'https://open.mapquestapi.com/staticmap/v4/getmap?key=$apikey&size=400,800&zoom=14&center=${SelectedPlace.location.latitude},${SelectedPlace.location.longitude}&mcenter=${SelectedPlace.location.latitude},${SelectedPlace.location.longitude}';
    setState(() {
      _previewUrlImage = mapimage;
    });
    return mapimage;
  }

  void initState() {
    super.initState();
    SelectedPlace =  Provider.of<PlaceProvider>(context,listen: false).getPlaceByid(widget.id);
    SetImage();
    _controller = VideoPlayerController.file(
        SelectedPlace.Vid)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_rounded)),

        title: Text('Detail Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                      : Container(),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 325,
                  width: double.infinity,
                  child: _previewUrlImage == null
                      ? Center(child: Text('No Location Chosen', textAlign: TextAlign.center,)) :
                  Image.network(_previewUrlImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,),
                    decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
