import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Text(
            'Hola, mundo!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}