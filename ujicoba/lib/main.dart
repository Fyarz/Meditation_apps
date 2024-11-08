import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'widgets/ambience.dart';
import 'widgets/move.dart';
import 'core/constants/images.dart';

void main() {
  runApp(const MeditationApp());
}

class MeditationApp extends StatelessWidget {
  const MeditationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // Halaman Sleep sebagai default

  // Daftar halaman yang akan ditampilkan
  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    const MyApp(),
    const SleepPage(),
  ];

  // Fungsi untuk mengubah halaman saat tombol di klik
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Ambience',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nightlight_round),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Move',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Halaman Sleep
class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlaying;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Fungsi untuk memutar audio
  void _playAudio(String audioPath) async {
    if (_currentlyPlaying == audioPath) {
      await _audioPlayer.stop();
      setState(() {
        _currentlyPlaying = null;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer
          .play(audioPath as Source); // Menggunakan AssetSource untuk file di assets
      setState(() {
        _currentlyPlaying = audioPath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage(Images.profile),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Soundscapes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildSoundscapeItem(
              Images.heavy_rain, 'Heavy Rain', 'assets/audio/Hujan_Petir.mp3'),
          _buildSoundscapeItem(Images.piano_waves, 'Piano Waves',
              'assets/audio/piano_waves.mp3'),
          _buildSoundscapeItem(Images.ocean, 'Ocean', 'assets/audio/ocean.mp3'),
          _buildSoundscapeItem(
              Images.light_rain, 'Light Rain', 'assets/audio/light_rain.mp3'),
          const SizedBox(height: 20),
          const Text(
            'Meditate before Sleep',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildMeditationCard('Advanced Awareness', '10 min'),
          _buildMeditationCard('Overcome Procrastination', '15 min'),
        ],
      ),
    );
  }

  // Fungsi yang diperbarui untuk membangun item soundscape dengan gambar dan aksi play audio
  Widget _buildSoundscapeItem(
      String imagePath, String title, String audioPath) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        radius: 28.0,
      ),
      title: Text(title),
      trailing: IconButton(
        icon: Icon(
          _currentlyPlaying == audioPath ? Icons.pause : Icons.play_arrow,
        ),
        onPressed: () {
          _playAudio(audioPath); // Memutar audio saat tombol play ditekan
        },
      ),
    );
  }

  Widget _buildMeditationCard(String title, String duration) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(duration),
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.self_improvement, color: Colors.white),
        ),
        onTap: () {
          // Tambahkan aksi ketika kartu meditasi ditekan
        },
      ),
    );
  }
}
