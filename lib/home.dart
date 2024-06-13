import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:movie_db_flutter/models/movie.dart';
import 'package:movie_db_flutter/movie_card.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> futureMovies;
  late Future<List<Movie>> futureTopRatedMovies;
  late Future<List<Movie>> futureUpcomingMovies;

  @override
  void initState() {
    super.initState();
    // futureMovies = getMovies();
    futureMovies = getMovies('https://api.themoviedb.org/3/trending/all/day?api_key=034ff4e6155c3bfddaa47e200292a3e3');
    futureTopRatedMovies = getMovies('https://api.themoviedb.org/3/movie/top_rated?api_key=034ff4e6155c3bfddaa47e200292a3e3&language=en-US&page=1');
    futureUpcomingMovies = getMovies('https://api.themoviedb.org/3/movie/upcoming?api_key=034ff4e6155c3bfddaa47e200292a3e3&language=en-US&page=1');
  }

  Future<List<Movie>> getMovies(String url) async {
    final response = await http.get(Uri.parse(url));

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      var getMoviesData = json.decode(response.body);
      var listMovies = (getMoviesData['results'] as List)
          .map((i) => Movie.fromJson(i))
          .toList();
      return listMovies;
    } else {
      throw Exception('Failed to load Posts');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Putra Movie DB'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Trending Movies Today'),
            _buildMovieList(futureMovies),
            _buildSectionTitle('Top Rated Movies'),
            _buildMovieList(futureTopRatedMovies),
            _buildSectionTitle('Upcoming Movies'),
            _buildMovieList(futureUpcomingMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMovieList(Future<List<Movie>> futureMovies) {
    return FutureBuilder<List<Movie>>(
      future: futureMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Movies Available'));
        } else {
          var movies = snapshot.data!.take(4).toList(); // Ambil 4 film pertama
          return SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: MovieCard(movies: movies[index]),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Putra Movie DB'),
  //       centerTitle: true,
  //     ),
  //     //FutureBuilder untuk mengambil data film dan menampilkan dalam GridView
  //     body: FutureBuilder<List<Movie>>(
  //       future: futureMovies,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return const Center(child: Text('No Movies Available'));
  //         } else {
  //           // Ambil hanya 4 film pertama
  //           var movies = snapshot.data!.take(4).toList();
  //           return Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Text(
  //                   'Trending Movies Today',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //
  //               SizedBox(
  //                 height: 300,
  //                 child: ListView.builder(
  //                     scrollDirection: Axis.horizontal,
  //                     itemCount: movies.length,
  //                     itemBuilder: (context, index){
  //                       return Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: SizedBox(
  //                           width: 150,
  //                           child: MovieCard(movies: movies[index]),
  //                         ),
  //                       );
  //                     },
  //                 ),
  //               ),
  //
  //               //Grid View
  //               // Expanded(
  //               //     child: GridView.builder(
  //               //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               //           crossAxisCount: 2,
  //               //           childAspectRatio: 0.7,
  //               //         ),
  //               //         // itemCount: snapshot.data!.length,
  //               //         itemCount: movies.length,
  //               //         itemBuilder: (context, index) {
  //               //           return MovieCard(movies: snapshot.data![index]);
  //               //         },
  //               //     ),
  //               // ),
  //             ],
  //           );
  //           // return
  //         }
  //       },
  //     ),
  //   );
  // }
}