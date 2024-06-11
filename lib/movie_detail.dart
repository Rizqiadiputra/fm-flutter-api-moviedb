import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_db_flutter/models/movie.dart';

class DetailMovie extends StatelessWidget {
  final Movie movies;
  const DetailMovie({ Key? key, required this.movies }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Page'),
        ),
        body: SafeArea(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Text('id: ${posts.id}'),
              Text('Title: ${movies.title}'),
              const SizedBox(
                height: 20,
              ),
            ])),
        );
    }
}