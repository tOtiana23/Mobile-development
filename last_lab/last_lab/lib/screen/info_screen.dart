import 'package:flutter/material.dart';

// Экран с информацией о студенте (обо мне, получается)
// Ну тут даже ничего интересного нет
class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("О студенте")),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 25),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person_2, size: 50, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  "Бусыгина Татьяна",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'ИВТ-22',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
