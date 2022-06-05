import 'package:pep_talk/Screens/places_details_screen.dart';
import 'package:pep_talk/providers/place_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pep_talk/Screens/add_places_screen.dart';

class PlaceListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Place'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddScreen()));
          },
              icon: Icon(Icons.add)
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<PlaceProvider>(context,listen: false).fetchAndSetPlaces(),
          builder: (context,snapshot)=> snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator(),) :
          Consumer<PlaceProvider>(
          child: Center(child: Text('No Places , Add Some Places !!!'),),
          builder: (context,P,child){
            return  Provider.of<PlaceProvider>(context).PlaceListHolder.length <=0 ? child! : ListView.builder(
                itemCount: Provider.of<PlaceProvider>(context).PlaceListHolder.length,
                itemBuilder: (context,i){
                 return Padding(
                   padding: EdgeInsets.all(6.0),
                   child: ListTile(
                     onTap: (){
                       Navigator.push(context,
                           MaterialPageRoute(builder:(context)=>DetailsPage(
                               id: Provider.of<PlaceProvider>(context,listen: false).PlaceListHolder[i].id) ));
                     },
                     leading: CircleAvatar(
                       backgroundImage: FileImage(Provider.of<PlaceProvider>(context,listen: false).PlaceListHolder[i].Thumb),
                       radius: 30,),
                     title: Text(Provider.of<PlaceProvider>(context,listen: false).PlaceListHolder[i].title),
                     subtitle: Text(Provider.of<PlaceProvider>(context,listen: false).PlaceListHolder[i].id),
                     trailing: Text(Provider.of<PlaceProvider>(context,listen: false).PlaceListHolder[i].location.address),
                   ),
                 );
            });
          },
      ),
        ),),
    );
  }
}
