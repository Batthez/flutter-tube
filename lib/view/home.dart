import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube_app/bloc/FavoriteBloc.dart';
import 'package:flutter_tube_app/bloc/videos_bloc.dart';
import 'package:flutter_tube_app/delegates/data_search.dart';
import 'package:flutter_tube_app/models/video.dart';
import 'package:flutter_tube_app/view/favorites.dart';
import 'package:flutter_tube_app/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 30,
          child: Image.asset("images/youtube-logo-large.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.white54,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String,Video>>(
              initialData: {},
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context,snapshot){
                if(snapshot.hasData) return Text("${snapshot.data.length}", style: TextStyle(color: Colors.grey[500]),);
                else return Container();

              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.star, color: Colors.grey[500],),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Favorites()));
              }
          ),
          IconButton(
              icon: Icon(Icons.search, color: Colors.grey[500],),
              onPressed: () async {
                String result =  await showSearch(context: context, delegate: DataSearch());
                if(result != null) BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
              )
        ],
      ),
      body: StreamBuilder<List<Video>>(
        initialData: [],
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemBuilder: (context, index){
                      if(index < snapshot.data.length)
                        return VideoTile(snapshot.data[index]);
                      else if(index > 1){
                        BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                        return Container(
                          height: 40,
                          width: 40,
                          alignment: AlignmentDirectional.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        );
                      }else {
                        return Container();
                      }

                },
              itemCount: snapshot.data.length + 1,
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
