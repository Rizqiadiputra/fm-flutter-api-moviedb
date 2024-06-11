import 'package:flutter/material.dart';
import 'package:movie_db_flutter/models/movie.dart';
import 'package:movie_db_flutter/movie_detail.dart';

class MovieCard extends StatelessWidget{
  const MovieCard({Key? key, required this.movies}):super(key: key);
  final Movie movies;

  @override
  Widget build(BuildContext context){
    return InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context){
                return DetailMovie(movies: movies);
              }),
            ),
          );
        },
        child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movies.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
    }
}