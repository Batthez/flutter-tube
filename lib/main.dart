import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube_app/api.dart';
import 'package:flutter_tube_app/bloc/FavoriteBloc.dart';
import 'package:flutter_tube_app/view/home.dart';

import 'bloc/videos_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      child: MaterialApp(
        title: 'FlutterTube',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
























