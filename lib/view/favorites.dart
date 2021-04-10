
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube_app/bloc/FavoriteBloc.dart';
import 'package:flutter_tube_app/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../api.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.getBloc<FavoriteBloc>();


    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<Map<String,Video>>(
        initialData: {},
        stream: bloc.outFav,
        builder: (context,snapshot){
          return ListView(
            children: snapshot.data.values.map((video){
              return InkWell(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                      child: Text(video.title, style: TextStyle(color: Colors.grey),maxLines: 2,),
                    )
                  ],
                ),
                onTap: (){
                  FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);
                },
                onLongPress: (){
                  bloc.toggleFavorite(video);
                },
              )  ;
            }).toList(),
          );
        },
      ),
    );
  }
}
