import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ujicoba/core/constants/images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MeditationPage(),
    );
  }
}

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  int selectedTime = 5;
  int remainingTime = 0;
  Timer? countdownTimer;
  bool isMeditating = false;

  void startTimer() {
    setState(() {
      remainingTime =
          selectedTime * 60; // Mengatur waktu berdasarkan menit yang dipilih
      isMeditating = true;
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          isMeditating = false;
        });
        // Tambahkan logika jika ingin melakukan sesuatu saat waktu habis
      }
    });
  }

  void stopTimer() {
    countdownTimer?.cancel();
    setState(() {
      isMeditating = false;
      remainingTime = 0;
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("On the go")),
      body: Stack(
        children: [
          // Gambar background dengan Image.asset
          Positioned.fill(
            child: Image.asset(
              Images.background,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "What are you doing?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "How many minutes do you have?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [5, 10, 20].map((time) {
                    return GestureDetector(
                      onTap: () {
                        if (!isMeditating) {
                          setState(() {
                            selectedTime = time;
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: selectedTime == time
                              ? Colors.blue
                              : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "$time min",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  isMeditating
                      ? "Time Remaining: ${formatTime(remainingTime)}"
                      : "Press start to meditate",
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isMeditating ? stopTimer : startTimer,
                  child: Text(
                      isMeditating ? "Stop Meditation" : "Start Meditation"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
