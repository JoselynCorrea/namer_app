import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

const String tmdbApiKey = '776b1ab80df49c91246a7811ca592f5d';
const String language = 'es-ES';
const int page = 1;
const String imageBase = 'https://image.tmdb.org/t/p/w500';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo TMDb',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MovieCatalogScreen(),
    );
  }
}

class MovieCatalogScreen extends StatefulWidget {
  const MovieCatalogScreen({super.key});
  @override
  State<MovieCatalogScreen> createState() => _MovieCatalogScreenState();
}

class _MovieCatalogScreenState extends State<MovieCatalogScreen> {
  bool _loading = true;
  String? _error;
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final url = Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=$tmdbApiKey&language=$language&page=$page');

         final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final results = json['results'] as List<dynamic>? ?? [];
        setState(() {
          _movies = results;
          _loading = false;
        });
      } else {
        setState(() {
          _error =
              'Error HTTP ${response.statusCode}: ${response.reasonPhrase}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Exception: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Películas usando API TMDb)'),
        centerTitle: true,
      ),
      body: _loading
    ? const Center(child: CircularProgressIndicator())
    : _error != null
        ? Center(child: Text(_error!))
        : Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Películas Populares',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: ListView.separated(
                    itemCount: _movies.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final movie = _movies[index];
                      final title = movie['title'] ?? 'Sin título';
                      final overview = movie['overview'] ?? 'Sin descripción';
                      final releaseDate = (movie['release_date'] ?? '') as String;
                      final year = releaseDate.isNotEmpty
                          ? releaseDate.split('-').first
                          : '—';
                      final posterPath = movie['poster_path'];
                      final posterUrl = posterPath != null
                          ? '$imageBase$posterPath'
                          : null;

                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: posterUrl != null
                                    ? Image.network(
                                        posterUrl,
                                        width: 90,
                                        height: 130,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, st) =>
                                            const Icon(Icons.broken_image),
                                      )
                                    : Container(
                                        width: 90,
                                        height: 130,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.movie,
                                            size: 40, color: Colors.black54),
                                      ),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Año: $year',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      overview,
                                      style: const TextStyle(fontSize: 15),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
