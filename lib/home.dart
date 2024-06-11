import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:movie_db_flutter/models/movie.dart';
import 'package:movie_db_flutter/movie_card.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget{
  Home({Key? key}) :super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Movie>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/all/day?api_key=034ff4e6155c3bfddaa47e200292a3e3'));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // var getPostsData = json.decode(response.body) as List;
      // var listPosts = getPostsData.map((i) => Posts.fromJson(i)).toList();
      var getPostsData = json.decode(response.body);
      var listPosts = (getPostsData['results'] as List)
          .map((i) => Movie.fromJson(i))
          .toList();
      return listPosts;
    } else {
      throw Exception('Failed to load Posts');
    }
  }

  late Future<List<Movie>> futurePosts;

  @override
  void initState() {
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('Putra Movie DB'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: FutureBuilder<List<Movie>>(
                future: futurePosts,
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemBuilder: ((context, index){
                          var post = (snapshot.data as List<Movie>)[index];
                          return Column(
                            children:[
                              MovieCard(
                                movies: Movie(
                                  // id: post.id,
                                    title: post.title),
                              ),
                              SizedBox(height:20)
                            ],
                          );
                        }),
                        separatorBuilder: (context, index){
                          return const Divider();
                        },
                        itemCount:(snapshot.data as List<Movie>).length);
                  }else if (snapshot.hasError){
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ),
    );
  }
}