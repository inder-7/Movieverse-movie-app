import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Dark background
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with transparent background and movie name
          SliverAppBar(
            expandedHeight: 300.0, // Height of the image section
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white), // White back button
              onPressed: () => Navigator.pop(context),
            ),
            
            flexibleSpace: FlexibleSpaceBar(
              background: movie['image'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        movie['image']['original'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  : Container(
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'No Image Available',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // movie tittle 
                      Text(
              movie['name'] ?? 'Movie Details',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),),
                      // Movie Summary
                      Text(
                        movie['summary'] != null
                            ? (movie['summary'] as String).replaceAll(RegExp('<[^>]*>'), '') // Strip HTML tags
                            : 'No Summary Available',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 16.0),
                      // Rating, Language, Premiere, Score
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Rating:', movie['rating'] != null ? movie['rating']['average'].toString() : 'N/A'),
                          _buildDetailRow('Language:', movie['language'] ?? 'N/A'),
                          _buildDetailRow('Premiere:', movie['premiered'] ?? 'N/A'),
                          _buildDetailRow('Score:', movie['score']?.toString() ?? 'N/A'),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      // Watch This Movie Circular Button with Text and Icon
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Implement your watch movie logic here
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Watch Movie'),
                                content: Text('You can now watch ${movie['name']} movie!'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.redAccent, Colors.orangeAccent], // Gradient for modern effect
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Watch Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the detail rows
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
