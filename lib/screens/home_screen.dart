import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details_screen.dart';
import 'search_screen.dart'; // Import the SearchScreen
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List> categorizedMovies = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/shows'));
      if (response.statusCode == 200) {
        final movies = json.decode(response.body);

        Map<String, List> tempCategorizedMovies = {};
        for (var movie in movies) {
          final genres = movie['genres'] ?? [];
          for (String genre in genres) {
            if (!tempCategorizedMovies.containsKey(genre)) {
              tempCategorizedMovies[genre] = [];
            }
            tempCategorizedMovies[genre]!.add(movie);
          }
        }

        setState(() {
          categorizedMovies = tempCategorizedMovies;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch data. Please try again later.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
  title: Row(
    children: [
      // Add image before the title text
      Image.asset(
        'assets/splash_image.png', // Replace with your asset path
        height: 30, // Adjust the size of the image
        width: 30, // Adjust the size of the image
      ),
      SizedBox(width: 8), // Space between image and text
      Text(
        'MOVIEVERSE',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
    ],
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.white),
  actions: [
    IconButton(
      icon: Icon(Icons.search, color: Colors.white),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(), // Navigate to SearchScreen
          ),
        );
      },
    ),
  ],
  flexibleSpace: ClipRRect(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        color: Colors.black.withOpacity(0.3),
      ),
    ),
  ),
)
,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: categorizedMovies.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: entry.value.length,
                              itemBuilder: (context, index) {
                                final movie = entry.value[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(movie: movie),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 180,
                                    margin: EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: movie['image'] != null
                                          ? Image.network(
                                              movie['image']['medium'],
                                              height: 200,
                                              width: 180,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              color: Colors.grey,
                                              child: Center(
                                                child: Text(
                                                  'No Image',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
    );
  }
}
