import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Function to handle search
  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _searchResults = data.map((e) => e['show']).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch search results. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Search Movies',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) => _searchMovies(value),
            ),
            SizedBox(height: 16),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (_errorMessage.isNotEmpty)
              Center(
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  itemCount: _searchResults.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of tiles in one row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4, // Adjust tile aspect ratio
                  ),
                  itemBuilder: (context, index) {
                    final movie = _searchResults[index];
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: movie['image'] != null
                              ? Image.network(
                                  movie['image']['medium'],
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
        ),
      ),
    );
  }
}
