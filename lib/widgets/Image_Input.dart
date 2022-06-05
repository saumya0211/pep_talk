import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageInput extends StatefulWidget {
  Function onSelected;
  ImageInput({required this.onSelected});
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile ? _referenceXFileVid;
  File? _referenceVidFile;

  Future<void> TakePic() async{
    final _imagePicker = ImagePicker();
    final NewFile =  await _imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: Duration(minutes: 1));

      setState(() {
        _referenceVidFile = File(NewFile!.path);
        _referenceXFileVid = NewFile;
      });
  }

  Future<String?> VideoThumbNail(XFile Video) async{

    final File = await VideoThumbnail.thumbnailFile(
      video: Video.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 267,
      maxWidth: 175,// specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    print(File);
    return File;

  }



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 267,
          width: 175,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
          ),
          child: _referenceVidFile!= null ?
           FutureBuilder<String?>(
               future: VideoThumbNail(_referenceXFileVid!),
               builder: (context,S)  {
                 if(S.hasData){
                   final ImagePath = S.data;
                   final CurrentThumbImg =  Image.file(File(ImagePath!),
                   height: 267,
                   width: 175,
                   fit: BoxFit.cover,);

                   SaveVidAndThumb(_referenceVidFile!,File(ImagePath));
                   return CurrentThumbImg;
                 }else{
                   return Center(child: Text('Saumya Made Mistake',textAlign: TextAlign.center,));
                 }
               }) : Text('No Video Taken',textAlign: TextAlign.center,),
        ),
        SizedBox(width: 10,),

        Expanded(
          child: FlatButton.icon(onPressed: (){
              TakePic();
          },
              icon: Icon(Icons.camera),
              label: Text('Take Video'),
              textColor: Theme.of(context).primaryColor,),
        ),
      ],
    );
  }
  Future<Void> SaveVidAndThumb(File Video,File Thumbnail) async{
    final appDir = await syspath.getApplicationDocumentsDirectory();
    print(p.basename(Video.path));
    print(p.basename(Thumbnail.path));
    final Savedvideo = await Video.copy('${appDir.path}/${p.basename(Video.path)}');
    final SavedThumb = await Thumbnail.copy('${appDir.path}/${p.basename(Thumbnail.path)}');
    return widget.onSelected(Savedvideo,SavedThumb);
  }
}
