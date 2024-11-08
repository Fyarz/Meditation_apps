import 'package:flutter/material.dart';
import 'package:ujicoba/core/constants/images.dart';

void main() {
  runApp(const AmbianceApp());
}

class AmbianceApp extends StatelessWidget {
  const AmbianceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> sessions = [
    {
      "title": "Ode to Summer's Night",
      "duration": "42 min",
      "image": "assets/images/summer_night.jpg"
    },
    {
      "title": "Deep Sea Slumber",
      "duration": "50 min",
      "image": "assets/images/deep_sea.jpg"
    },
    {
      "title": "Mindful Shores",
      "duration": "41 min",
      "image": "assets/images/mindful_shores.jpg"
    },
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.share, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          // Background container
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.ambiance), // Specify your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ambience",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.purple),
                    SizedBox(width: 5),
                    Text("82,112 Plays", style: TextStyle(color: Colors.grey)),
                    Spacer(),
                    Icon(Icons.star, color: Colors.yellow),
                    Text("4.9", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 50),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage(Images.flower),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                    "When feeling stressed and anxious, settle your racing mind with soft, soothing sounds guaranteed to help you find peace.",
                    style: TextStyle(color: Color.fromARGB(255, 8, 8, 8))),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(sessions[index]["title"]),
                        subtitle: Text(sessions[index]["duration"]),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(sessions[index]["image"]),
                        ),
                        onTap: () {
                          // Define the functionality to play each session
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
